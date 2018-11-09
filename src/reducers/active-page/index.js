import * as ActionType from "../../action-types"
import initialState from "./initial-state"
import * as ActivePage from "../../enum-active-pages"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.ENTER_HOME_PAGE]: () => ActivePage.HOME_PAGE,
        [ActionType.ENTER_LOGIN_PAGE]: () => ActivePage.LOGIN_PAGE,
        [ActionType.ENTER_PRODUCT_ADD_PAGE]: () => ActivePage.PRODUCT_ADD_PAGE,
        [ActionType.ENTER_PRODUCT_EDIT_PAGE]: () => ActivePage.PRODUCT_EDIT_PAGE
    }

    if(action.type in handlers)
    {
        return handlers[action.type](
            state,
            action
        )
    }
    else
    {
        return state
    }
}

export function handleEnterHomePage(state, action)
{
    return ActivePage.HOME_PAGE
}

export function handleEnterLoginPage(state, action)
{
    return ActivePage.LOGIN_PAGE
}

export function handleEnterProductAddPage(state, action)
{
    return ActivePage.PRODUCT_ADD_PAGE
}

export function handleEnterProductEditPage(state, action)
{
    return ActivePage.PRODUCT_EDIT_PAGE
}