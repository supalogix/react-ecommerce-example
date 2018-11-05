import * as ActionType from "../action-types"

export const loadApp = (appSettings) => ({
    type: ActionType.LOAD_APP,
    payload: appSettings
})

export const visitHomePage = () => ({
    type: ActionType.VISIT_HOME_PAGE
})

export const enterHomePage = () => ({
    type: ActionType.ENTER_HOME_PAGE
})

export const leaveHomePage = () => ({
    type: ActionType.LEAVE_HOME_PAGE
})

export const fetchInitHomePageData = () => ({
    type: ActionType.FETCH_INIT_HOME_PAGE_DATA
})

export const receiveInitHomePageData = payload => ({
    type: ActionType.RECEIVE_INIT_HOME_PAGE_DATA,
    payload
})

export const receiveInitHomePageError = payload => ({
    type: ActionType.RECEIVE_INIT_HOME_PAGE_ERROR,
    payload
})

export const addProductToCart = (productId) => ({
    type: ActionType.ADD_PRODUCT_TO_CART,
    payload: productId
})