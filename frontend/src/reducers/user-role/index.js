import * as ActionType from "../../action-types"
import initialState from "./initial-state"
import * as Role from "../../enum-roles"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.RECEIVE_LOGIN_OK_DATA]: handleReceiveLoginOkData,
        [ActionType.LOGOUT]: handleLogout
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

export function handleReceiveLoginOkData(state, action)
{
    return action.payload
}

export function handleLogout(state, action)
{
    return Role.GUEST
}