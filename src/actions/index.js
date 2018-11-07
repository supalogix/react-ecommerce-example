import * as ActionType from "../action-types"

export const loadApp = (appSettings) => ({
    type: ActionType.LOAD_APP,
    payload: appSettings
})

export const visitHomePage = () => ({
    type: ActionType.VISIT_HOME_PAGE
})

export const visitLoginPage = () => ({
    type: ActionType.VISIT_LOGIN_PAGE
})

export const visitCartPage = () => ({
    type: ActionType.VISIT_CART_PAGE
})

// Enter and Leave Methods
export const enterHomePage = () => ({
    type: ActionType.ENTER_HOME_PAGE
})

export const exitHomePage = () => ({
    type: ActionType.EXIT_HOME_PAGE
})

export const enterLoginPage = () => ({
    type: ActionType.ENTER_LOGIN_PAGE
})

export const exitLoginPage = () => ({
    type: ActionType.EXIT_LOGIN_PAGE
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

export const changeUsername = (username) => ({
    type: ActionType.CHANGE_USERNAME,
    payload: username
})

export const changePassword = (username) => ({
    type: ActionType.CHANGE_PASSWORD,
    payload: username
})

export const requestLogin = (username,password) => ({
    type: ActionType.REQUEST_LOGIN,
    payload: {
        username,
        password
    }
})

export const prepareLoginRequest = () => ({
    type: ActionType.PREPARE_LOGIN_REQUEST,
})

export const receiveLoginOkData = () => ({
    type: ActionType.RECEIVE_LOGIN_OK_DATA
})

export const addProductToCart = (productId) => ({
    type: ActionType.ADD_PRODUCT_TO_CART,
    payload: productId
})