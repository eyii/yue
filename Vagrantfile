require 'yaml'
require 'fileutils'

required_plugins = %w( vagrant-hostmanager vagrant-vbguest )
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

domains = {
  frontend: 'f.cn',
  backend:  'b.cn'
}

config = {
  local: './yii/vagrant/config/vagrant-local.yml',
  example: './yii/vagrant/config/vagrant-local.example.yml'
}

FileUtils.cp config[:example], config[:local] unless File.exist?(config[:local])
options = YAML.load_file config[:local]

if options['github_token'].nil? || options['github_token'].to_s.length != 40
  puts "You must place REAL GitHub token into configuration:\n/yii2-app-advanced/vagrant/config/vagrant-local.yml"
  exit
end

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.box_check_update = options['box_check_update']

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = options['cpus']
    vb.memory = options['memory']
    vb.name = options['machine_name']
  end

  config.vm.define options['machine_name']

  config.vm.hostname = options['machine_name']

 # config.vm.network 'private_network', ip: options['ip']
  config.vm.network "public_network", :bridge=>'enp1s0', ip: options['ip']
  config.vm.synced_folder './yii/', '/app', owner: 'vagrant', group: 'vagrant'
 config.vm.synced_folder './yii/', '/app', owner: 'vagrant', group: 'vagrant'
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # hosts settings (host machine)
  config.vm.provision :hostmanager
  config.hostmanager.enabled            = true
  config.hostmanager.manage_host        = true
  config.hostmanager.ignore_private_ip  = false
  config.hostmanager.include_offline    = true
  config.hostmanager.aliases            = domains.values

  # provisioners
  config.vm.provision 'shell', path: './yii/vagrant/provision/once-as-root.sh', args: [options['timezone']]
  config.vm.provision 'shell', path: './yii/vagrant/provision/once-as-vagrant.sh', args: [options['github_token']], privileged: false
  config.vm.provision 'shell', path: './yii/vagrant/provision/always-as-root.sh', run: 'always'

  # post-install message (vagrant console)
  config.vm.post_up_message = "Frontend URL: http://#{domains[:frontend]}\nBackend URL: http://#{domains[:backend]}"
end
