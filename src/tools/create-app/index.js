import React from 'react';
import { App } from "../../components"
import {Provider} from "react-redux"
import createStore from "../create-store-from-state"

export default state => {
    const store = createStore(state)

    return <Provider store={store}>
        <App />
    </Provider>
}