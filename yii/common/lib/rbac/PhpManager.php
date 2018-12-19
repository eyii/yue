<?php


namespace yii\rbac;

use Yii;
use yii\base\InvalidArgumentException;
use yii\base\InvalidCallException;
use yii\helpers\VarDumper;

class PhpManager extends BaseManager
{

    public $itemFile = '@app/rbac/items.php';

    public $assignmentFile = '@app/rbac/assignments.php';

    public $ruleFile = '@app/rbac/rules.php';


    protected $items = [];

    protected $children = [];

    protected $assignments = [];

    protected $rules = [];



    public function init()
    {
        parent::init();
        $this->itemFile = Yii::getAlias($this->itemFile);
        $this->assignmentFile = Yii::getAlias($this->assignmentFile);
        $this->ruleFile = Yii::getAlias($this->ruleFile);
        $this->load();
    }

    function checkAccess($userId, $permissionName, $params = [])
    {
        $assignments = $this->getAssignments($userId);

        if ($this->hasNoAssignments($assignments)) return false;


        return $this->checkAccessRecursive($userId, $permissionName, $params, $assignments);
    }

   function getAssignments($userId){
        return isset($this->assignments[$userId]) ? $this->assignments[$userId] : [];
    }


    protected function checkAccessRecursive($user, $itemName, $params, $assignments)
    {
        if (!isset($this->items[$itemName])) return false;


        /* @var $item Item */
        $item = $this->items[$itemName];
        Yii::debug($item instanceof Role ? "Checking role: $itemName" : "Checking permission : $itemName", __METHOD__);

        if (!$this->executeRule($user, $item, $params)) return false;


        if (isset($assignments[$itemName]) || in_array($itemName, $this->defaultRoles)) return true;


        foreach ($this->children as $parentName => $children) {
            if (isset($children[$itemName]) && $this->checkAccessRecursive($user, $parentName, $params, $assignments)) return true;

        }

        return false;
    }

   function canAddChild($parent, $child){
        return !$this->detectLoop($parent, $child);
    }

   function addChild($parent, $child)
    {
        if (!isset($this->items[$parent->name], $this->items[$child->name])) throw new InvalidArgumentException("Either '{$parent->name}' or '{$child->name}' does not exist.");


        if ($parent->name === $child->name) throw new InvalidArgumentException("Cannot add '{$parent->name} ' as a child of itself.");

        if ($parent instanceof Permission && $child instanceof Role) throw new InvalidArgumentException('Cannot add a role as a child of a permission.');


        if ($this->detectLoop($parent, $child)) throw new InvalidCallException("Cannot add '{$child->name}' as a child of '{$parent->name}'. A loop has been detected.");

        if (isset($this->children[$parent->name][$child->name])) throw new InvalidCallException("The item '{$parent->name}' already has a child '{$child->name}'.");

        $this->children[$parent->name][$child->name] = $this->items[$child->name];
        $this->saveItems();

        return true;
    }


    protected function detectLoop($parent, $child)
    {
        if ($child->name === $parent->name) return true;

        if (!isset($this->children[$child->name], $this->items[$parent->name])) return false;

        foreach ($this->children[$child->name] as $grandchild) if ($this->detectLoop($parent, $grandchild)) return true;



        return false;
    }

     function removeChild($parent, $child)
    {
        if (!isset($this->children[$parent->name][$child->name]))  return false;
        unset($this->children[$parent->name][$child->name]);
        $this->saveItems();
        return true;



    }

    /**
     * {@inheritdoc}
     */
    public function removeChildren($parent)
    {
        if (!isset($this->children[$parent->name]))  return false;
        unset($this->children[$parent->name]);
        $this->saveItems();
        return true;



    }

    function hasChild($parent, $child)
    {
        return isset($this->children[$parent->name][$child->name]);
    }

    function assign($role, $userId)
    {
        if (!isset($this->items[$role->name])) throw new InvalidArgumentException("Unknown role '{$role->name}'.");
        elseif (isset($this->assignments[$userId][$role->name])) throw new InvalidArgumentException("Authorization item '{$role->name}' has already been assigned to user '$userId'.");


        $this->assignments[$userId][$role->name] = new Assignment(['userId' => $userId, 'roleName' => $role->name, 'createdAt' => time(),]);
        $this->saveAssignments();

        return $this->assignments[$userId][$role->name];
    }

   function revoke($role, $userId)
    {
        if (!isset($this->assignments[$userId][$role->name])) return false;
        unset($this->assignments[$userId][$role->name]);
        $this->saveAssignments();
        return true;
    }

     function revokeAll($userId)
    {
        if (!isset($this->assignments[$userId]) && is_array($this->assignments[$userId]))  return false;
        foreach ($this->assignments[$userId] as $itemName => $value) unset($this->assignments[$userId][$itemName]);

        $this->saveAssignments();
        return true;
    }
     function getAssignment($roleName, $userId){
        return isset($this->assignments[$userId][$roleName]) ? $this->assignments[$userId][$roleName] : null;
    }

   function getItems($type)
    {
        $items = [];
        foreach ($this->items as $name => $item) if ($item->type == $type) $items[$name] = $item;
        return $items;
    }


     function removeItem($item)
    {
        if (!isset($this->items[$item->name])) return false;
        foreach ($this->children as &$children) unset($children[$item->name]);

        foreach ($this->assignments as &$assignments) unset($assignments[$item->name]);

        unset($this->items[$item->name]);
        $this->saveItems();
        $this->saveAssignments();
        return true;



    }

    function getItem($name){
        return isset($this->items[$name]) ? $this->items[$name] : null;
    }

     function updateRule($name, $rule){
        if ($rule->name !== $name) unset($this->rules[$name]);

        $this->rules[$rule->name] = $rule;
        $this->saveRules();
        return true;
    }

    function getRule($name){
        return isset($this->rules[$name]) ? $this->rules[$name] : null;
    }

    function getRules(){
        return $this->rules;
    }
    function getRolesByUser($userId){
        $roles = $this->getDefaultRoleInstances();
        foreach ($this->getAssignments($userId) as $name => $assignment) {
            $role = $this->items[$assignment->roleName];
            if ($role->type === Item::TYPE_ROLE) $roles[$name] = $role;

        }

        return $roles;
    }

  function getChildRoles($roleName)
    {
        $role = $this->getRole($roleName);

        if ($role === null) throw new InvalidArgumentException("Role \"$roleName\" not found.");


        $result = [];
        $this->getChildrenRecursive($roleName, $result);

        $roles = [$roleName => $role];

        $roles += array_filter($this->getRoles(), function (Role $roleItem) use ($result) {
            return array_key_exists($roleItem->name, $result);
        });

        return $roles;
    }

    function getPermissionsByRole($roleName){
        $result = [];
        $this->getChildrenRecursive($roleName, $result);
        if (empty($result)) return [];

        $permissions = [];
        foreach (array_keys($result) as $itemName) if (isset($this->items[$itemName]) && $this->items[$itemName] instanceof Permission) $permissions[$itemName] = $this->items[$itemName];



        return $permissions;
    }


    protected function getChildrenRecursive($name, &$result)
    {
        if (!isset($this->children[$name])) return;
            foreach ($this->children[$name] as $child) {
                $result[$child->name] = true;
                $this->getChildrenRecursive($child->name, $result);
            }

    }

    function getPermissionsByUser($userId){
        $directPermission = $this->getDirectPermissionsByUser($userId);
        $inheritedPermission = $this->getInheritedPermissionsByUser($userId);

        return array_merge($directPermission, $inheritedPermission);
    }


    protected function getDirectPermissionsByUser($userId)
    {
        $permissions = [];
        foreach ($this->getAssignments($userId) as $name => $assignment) {
            $permission = $this->items[$assignment->roleName];
            if ($permission->type === Item::TYPE_PERMISSION) $permissions[$name] = $permission;

        }

        return $permissions;
    }


    protected function getInheritedPermissionsByUser($userId)
    {
        $assignments = $this->getAssignments($userId);
        $result = [];
        foreach (array_keys($assignments) as $roleName) $this->getChildrenRecursive($roleName, $result);
        if (empty($result)) return [];

        $permissions = [];
        foreach (array_keys($result) as $itemName) if (isset($this->items[$itemName]) && $this->items[$itemName] instanceof Permission) $permissions[$itemName] = $this->items[$itemName];

        return $permissions;
    }

     function getChildren($name){
        return isset($this->children[$name]) ? $this->children[$name] : [];
    }

     function removeAll(){
        $this->children = [];
        $this->items = [];
        $this->assignments = [];
        $this->rules = [];
        $this->save();
    }

   function removeAllPermissions(){
        $this->removeAllItems(Item::TYPE_PERMISSION);
    }

    function removeAllRoles(){
        $this->removeAllItems(Item::TYPE_ROLE);
    }


    protected function removeAllItems($type)
    {
        $names = [];
        foreach ($this->items as $name => $item) {
            if ($item->type == $type) {
                unset($this->items[$name]);
                $names[$name] = true;
            }
        }
        if (empty($names)) return;


        foreach ($this->assignments as $i => $assignments) {
            foreach ($assignments as $n => $assignment) if (isset($names[$assignment->roleName])) unset($this->assignments[$i][$n]);

        }
        foreach ($this->children as $name => $children) {
            if (isset($names[$name])) unset($this->children[$name]);
             else {
                foreach ($children as $childName => $item) if (isset($names[$childName])) unset($children[$childName]);
                $this->children[$name] = $children;
            }
        }

        $this->saveItems();
    }

     function removeAllRules(){
        foreach ($this->items as $item) $item->ruleName = null;

        $this->rules = [];
        $this->saveRules();
    }

     function removeAllAssignments(){
        $this->assignments = [];
        $this->saveAssignments();
    }


    protected function removeRule($rule)
    {
        if (!isset($this->rules[$rule->name]))  return false;
        unset($this->rules[$rule->name]);
        foreach ($this->items as $item) if ($item->ruleName === $rule->name) $item->ruleName = null;

      return true;
    }


    protected function addRule($rule)
    {
        $this->rules[$rule->name] = $rule;
        $this->saveRules();
        return true;
    }


    protected function updateItem($name, $item)
    {
        if ($name !== $item->name) {
            if (isset($this->items[$item->name])) throw new InvalidArgumentException("Unable to change the item name. The name '{$item->name}' is already used by another item.");

            unset($this->items[$name]);

            if (isset($this->children[$name])) {
                $this->children[$item->name] = $this->children[$name];
                unset($this->children[$name]);
            }
            foreach ($this->children as &$children) {
                if (!isset($children[$name])) continue;
                    $children[$item->name] = $children[$name];
                    unset($children[$name]);

            }
            foreach ($this->assignments as &$assignments) {
                if (!isset($assignments[$name])) continue;
                    $assignments[$item->name] = $assignments[$name];
                    $assignments[$item->name]->roleName = $item->name;
                    unset($assignments[$name]);

            }
            $this->saveAssignments();
        }

        $this->items[$item->name] = $item;

        $this->saveItems();
        return true;
    }


    protected function addItem($item)
    {
        $time = time();
       $item->createdAt === null&& $item->createdAt = $time;

      $item->updatedAt === null&& $item->updatedAt = $time;


        $this->items[$item->name] = $item;

        $this->saveItems();

        return true;
    }


    protected function load()
    {
        $this->children = [];
        $this->rules = [];
        $this->assignments = [];
        $this->items = [];

        $items = $this->loadFromFile($this->itemFile);
        $itemsMtime = @filemtime($this->itemFile);
        $assignments = $this->loadFromFile($this->assignmentFile);
        $assignmentsMtime = @filemtime($this->assignmentFile);
        $rules = $this->loadFromFile($this->ruleFile);

        foreach ($items as $name => $item) {
            $class = $item['type'] == Item::TYPE_PERMISSION ? Permission::className() : Role::className();

            $this->items[$name] = new $class([
                'name' => $name,
                'description' => isset($item['description']) ? $item['description'] : null,
                'ruleName' => isset($item['ruleName']) ? $item['ruleName'] : null,
                'data' => isset($item['data']) ? $item['data'] : null,
                'createdAt' => $itemsMtime,
                'updatedAt' => $itemsMtime,
            ]);
        }

        foreach ($items as $name => $item) {
            if (!isset($item['children'])) continue;
             foreach ($item['children'] as $childName) if (isset($this->items[$childName])) $this->children[$name][$childName] = $this->items[$childName];
        }

        foreach ($assignments as $userId => $roles) {
            foreach ($roles as $role) {
                $this->assignments[$userId][$role] = new Assignment(['userId' => $userId, 'roleName' => $role, 'createdAt' => $assignmentsMtime,]);
            }
        }

        foreach ($rules as $name => $ruleData) {
            $this->rules[$name] = unserialize($ruleData);
        }
    }


    protected function save()
    {
        $this->saveItems();
        $this->saveAssignments();
        $this->saveRules();
    }


    protected function loadFromFile($file)
    {
        if (is_file($file)) return require $file;


        return [];
    }


    protected function saveToFile($data, $file)
    {
        file_put_contents($file, "<?php\nreturn " . VarDumper::export($data) . ";\n", LOCK_EX);
        $this->invalidateScriptCache($file);
    }


    protected function invalidateScriptCache($file)
    {
      function_exists('opcache_invalidate')&& opcache_invalidate($file, true);

        function_exists('apc_delete_file')&& @apc_delete_file($file);

    }


    protected function saveItems()
    {
        $items = [];
        foreach ($this->items as $name => $item) {
            /* @var $item Item */
            $items[$name] = array_filter(['type' => $item->type, 'description' => $item->description, 'ruleName' => $item->ruleName, 'data' => $item->data,]);
            if (isset($this->children[$name])) foreach ($this->children[$name] as $child) $items[$name]['children'][] = $child->name;
        }
        $this->saveToFile($items, $this->itemFile);
    }

    /**
     * Saves assignments data into persistent storage.
     */
    protected function saveAssignments()
    {
        $assignmentData = [];
        foreach ($this->assignments as $userId => $assignments) {
            foreach ($assignments as $name => $assignment) $assignmentData[$userId][] = $assignment->roleName;
        }
        $this->saveToFile($assignmentData, $this->assignmentFile);
    }

    /**
     * Saves rules data into persistent storage.
     */
    protected function saveRules()
    {
        $rules = [];
        foreach ($this->rules as $name => $rule) $rules[$name] = serialize($rule);

        $this->saveToFile($rules, $this->ruleFile);
    }

    /**
     * {@inheritdoc}
     * @since 2.0.7
     */
    public function getUserIdsByRole($roleName)
    {
        $result = [];
        foreach ($this->assignments as $userID => $assignments) {
            foreach ($assignments as $userAssignment) if ($userAssignment->roleName === $roleName && $userAssignment->userId == $userID) $result[] = (string) $userID;
        }

        return $result;
    }
}
