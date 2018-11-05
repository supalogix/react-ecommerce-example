import {createStore} from "../../tools"
import {loadApp} from "../../actions"

const store = createStore()

const action = loadApp({
})

store.dispatch(action)

const state = store.getState()

export default state