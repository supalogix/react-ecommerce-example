import React from 'react';
import { App } from "../../components"
import {Provider} from "react-redux"
import reducers from "../../reducers"
import {
    createStore,
    combineReducers} from "redux"
import { ConnectedRouter } from "connected-react-router"

export default (state) => {
    const _reducers = combineReducers({
        ...reducers
    });
    const store = createStore(
        _reducers,
        state
    )

    return <Provider store={store}>
        <App />
    </Provider>
}