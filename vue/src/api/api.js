import axios from 'axios';


let base = 'http://f.cn';
export const requestLogin = (params,vue) => { params.url=`${base}/v1/user/login`; return new VPost(params,vue);};
export const setMenu = (id,params,vue) => { params.url=`${base}/v1/menu/`+id; return new VPatch(params,vue);};
export const delMenu = (id,params,vue) => { params.url=`${base}/v1/menu/`+id; return new VDel(params,vue);};
export const addMenu = (row,vue) => { params.url=`${base}/v1/menu`; return new VPost(row,vue);};
export const userReg = (params,vue) => { params.url=`${base}/v1/user/reg`; return new VPost(params,vue);};


export const getUserList = params => { return axios.get(`${base}/user/list`, { params: params }); };

export const getUserListPage = params => { return axios.get(`${base}/user/listpage`, { params: params }); };

export const removeUser = params => { return axios.get(`${base}/user/remove`, { params: params }); };

export const batchRemoveUser = params => { return axios.get(`${base}/user/batchremove`, { params: params }); };

export const editUser = params => { return axios.get(`${base}/user/edit`, { params: params }); };

export const addUser = params => { return axios.get(`${base}/user/add`, { params: params }); };
export const upload = params => { return axios.get(`${base}/user/add`, { params: params }); };

export const getMenus = (params,vue) => { params.url=`${base}/v1/menu`; return new VGet(params,vue);};
