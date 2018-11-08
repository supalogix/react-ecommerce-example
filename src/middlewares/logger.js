export default store => next => action => {
    // You can use these to manually debug what happens
    // while the application runs.

    console.log(
       "action: ",
       JSON.stringify(action, null, 2))
    
    //console.log(
    //   "store state: ",
    //   JSON.stringify(store.getState(), null, 2))

    next(action)
}