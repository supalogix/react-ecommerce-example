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
import enterHomePageHandler from "./middlewares/enter-home-page-handler"
import requestLoginHandler from "./middlewares/request-login-handler"
import requestAddProductHandler from "./middlewares/request-add-product-handler"
import requestEditProductHandler from "./middlewares/request-edit-product-handler"
import enterProductEditPageHandler from "./middlewares/enter-product-edit-page-handler"
import logger from "./middlewares/logger"
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
        mw(history),
        enterHomePageHandler,
        requestLoginHandler,
        requestAddProductHandler,
        requestEditProductHandler,
        enterProductEditPageHandler,
        logger
    ))

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

export const ProductAddPage = () => createRouteableComponent(
  () => store.dispatch(Action.enterProductAddPage()),
  () => store.dispatch(Action.exitProductAddPage()),
  App)

const onProductEditPageEnter = location => {
  /**
   * we need to manually parse the location string to 
   * find the id embedded in the url string
   */
  const id = location.href
    .match(/\/product-edit\/(\d+)/)[1]

  store.dispatch(Action.enterProductEditPage(id))
};

export const ProductEditPage = () => createRouteableComponent(
  onProductEditPageEnter,
  () => store.dispatch(Action.exitProductEditPage()),
  App)

export default () => <Provider store={store}>
    <ConnectedRouter history={history}>
      <Switch>
        <div>
          <Route exact path="/" component={HomePage} />
          <Route exact path="/login" component={LoginPage} />
          <Route exact path="/product-add" component={ProductAddPage} />
          <Route exact path="/product-edit/:id" component={ProductEditPage} />
        </div>
      </Switch>
    </ConnectedRouter>
</Provider>
