import {createStore, combineReducers} from "redux"
import defaultReducers from "../../reducers"

export default (
    _reducers, 
    _middlewares, 
    _initialState = {}) => 
{
    const reducers = combineReducers(
        _reducers || defaultReducers)

    const store = createStore(
        reducers, 
        _initialState)
    
    return store
}