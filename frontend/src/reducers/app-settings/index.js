import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.LOAD_APP]: handleLoadApp
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

export function handleLoadApp(state, action)
{
    return action.payload
}