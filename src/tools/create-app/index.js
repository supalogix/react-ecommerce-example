import React from 'react';
import { App } from "../../components"
import {Provider} from "react-redux"
import reducers from "../../reducers"
import mw from "../../middlewares/router"
import {
    applyMiddleware,
    createStore,
    compose,
    combineReducers} from "redux"
import {
    connectRouter,
    routerMiddleware
} from "connected-react-router"
import { createBrowserHistory } from 'history'
import { ConnectedRouter } from "connected-react-router"

export default (state) => {
    const history = createBrowserHistory()
    const _reducers = combineReducers({
        router: connectRouter(history),
        ...reducers
    });
    const _mw = compose(
        applyMiddleware(
            routerMiddleware(history),
            mw(history)))
    const store = createStore(
        _reducers,
        state,
        _mw
    )

    return <Provider store={store}>
        <ConnectedRouter history={history}>
            <App />
        </ConnectedRouter>
    </Provider>
}