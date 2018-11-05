import createStoreFromState from "../create-store-from-state"

export default (initialState, action) => {
    const store = createStoreFromState(initialState)
    store.dispatch(action)
    return store.getState()
}

