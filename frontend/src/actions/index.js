import * as ActionType from "../action-types"

export const loadApp = (appSettings) => ({
    type: ActionType.LOAD_APP,
    payload: appSettings
})

export const logout = () => ({
    type: ActionType.LOGOUT
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

export const visitProductAddPage = () => ({
    type: ActionType.VISIT_PRODUCT_ADD_PAGE
})

export const visitProductEditPage = () => ({
    type: ActionType.VISIT_PRODUCT_EDIT_PAGE
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

export const enterProductAddPage = () => ({
    type: ActionType.ENTER_PRODUCT_ADD_PAGE
})

export const exitProductAddPage = () => ({
    type: ActionType.EXIT_PRODUCT_ADD_PAGE
})

export const enterProductEditPage = (id) => ({
    type: ActionType.ENTER_PRODUCT_EDIT_PAGE,
    payload: id
})

export const exitProductEditPage = () => ({
    type: ActionType.EXIT_PRODUCT_EDIT_PAGE
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

export const receiveLoginOkData = userRole => ({
    type: ActionType.RECEIVE_LOGIN_OK_DATA,
    payload: userRole
})

export const receiveLoginDeniedData = () => ({
    type: ActionType.RECEIVE_LOGIN_OK_DATA
})

export const changeProductAddField = (name, value) => ({
    type: ActionType.CHANGE_PRODUCT_ADD_FIELD,
    payload: {
        name,
        value
    }
})

export const changeProductEditField = (name, value) => ({
    type: ActionType.CHANGE_PRODUCT_EDIT_FIELD,
    payload: {
        name,
        value
    }
})

export const requestAddProduct = () => ({
    type: ActionType.REQUEST_ADD_PRODUCT
})

export const prepareAddProductRequest = () => ({
    type: ActionType.PREPARE_ADD_PRODUCT_REQUEST
})

export const receiveAddProductOkData = () => ({
    type: ActionType.RECEIVE_ADD_PRODUCT_OK_DATA
})

export const receiveAddProductErrorData = () => ({
    type: ActionType.RECEIVE_ADD_PRODUCT_ERROR_DATA
})

export const fetchInitEditProductPageData = (id) => ({
    type: ActionType.FETCH_INIT_EDIT_PRODUCT_PAGE_DATA,
    payload: id
})

export const receiveInitEditProductPageData = (payload) => ({
    type: ActionType.RECEIVE_INIT_EDIT_PRODUCT_PAGE_DATA,
    payload
})

export const receiveInitEditProductPageError = (payload) => ({
    type: ActionType.RECEIVE_INIT_EDIT_PRODUCT_PAGE_ERROR,
    payload
})

export const requestEditProduct = () => ({
    type: ActionType.REQUEST_EDIT_PRODUCT
})

export const receiveEditProductOkData = (payload) => ({
    type: ActionType.RECEIVE_EDIT_PRODUCT_OK_DATA,
    payload
})

export const receiveEditProductErrorData = () => ({
    type: ActionType.RECEIVE_EDIT_PRODUCT_ERROR_DATA
})

export const editProduct = () => ({
    type: ActionType.EDIT_PRODUCT
})