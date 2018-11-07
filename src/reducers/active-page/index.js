import * as ActionType from "../../action-types"
import initialState from "./initial-state"
import * as ActivePage from "../../enum-active-pages"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.ENTER_HOME_PAGE]: handleEnterHomePage,
        [ActionType.ENTER_LOGIN_PAGE]: handleEnterLoginPage
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