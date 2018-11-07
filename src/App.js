import React, { Component } from 'react';
import {
  createApp, 
  createRouteableComponent
} from "./tools"
import {stub2} from "./stubs"
//import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import { Route, Switch } from "react-router"

import * as Action from "./actions"
import mw from "./middlewares/router"
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
import reducers from "./reducers"
import {Provider} from "react-redux"
import { App } from "./components"

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
    stub2,
    _mw
)

export const HomePage = () => createRouteableComponent(
  () => store.dispatch(Action.enterHomePage()),
  () => store.dispatch(Action.exitHomePage()),
  App)

export const LoginPage = () => createRouteableComponent(
  () => store.dispatch(Action.enterLoginPage()),
  () => store.dispatch(Action.exitLoginPage()),
  App)

export default () => <Provider store={store}>
    <ConnectedRouter history={history}>
      <Switch>
        <div>
          <Route exact path="/" component={HomePage} />
          <Route exact path="/login" component={LoginPage} />
        </div>
      </Switch>
    </ConnectedRouter>
</Provider>
