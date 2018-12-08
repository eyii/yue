export  const mutations = {
    INCREMENT(state) {
        state.count++
    },
    DECREMENT(state) {
        state.count--
    },
    setUsers(state,users){
        state.users=users
    } ,
}