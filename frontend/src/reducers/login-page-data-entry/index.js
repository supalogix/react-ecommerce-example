import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.EXIT_LOGIN_PAGE]: handleExitLoginPage,
        [ActionType.CHANGE_USERNAME]: handleChangeUsername,
        [ActionType.CHANGE_PASSWORD]: handleChangePassword,
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

export function handleChangeUsername(state, action)
{
    return {
        ...state,
        username: action.payload
    }
}

export function handleChangePassword(state, action)
{
    return {
        ...state,
        password: action.payload
    }
}

export function handleExitLoginPage(state, action)
{
    return initialState
}