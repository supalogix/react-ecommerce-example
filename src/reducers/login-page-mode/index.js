import * as ActionType from "../../action-types"
import * as Mode from "../../enum-modes"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.ENTER_LOGIN_PAGE]: handleEnterLoginPage,
        [ActionType.REQUEST_LOGIN]: handleRequestLogin,
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

export function handleEnterLoginPage(state, action)
{
    return Mode.LOGIN_PAGE_READY
}

export function handleRequestLogin(state, action)
{
    return Mode.LOGIN_PAGE_WAITING
}