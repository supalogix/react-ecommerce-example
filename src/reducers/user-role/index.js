import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
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