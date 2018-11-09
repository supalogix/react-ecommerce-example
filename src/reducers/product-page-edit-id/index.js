import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.ENTER_PRODUCT_EDIT_PAGE]: handleEnterProductEditPage,
        [ActionType.EXIT_PRODUCT_EDIT_PAGE]: handleExitProductEditPage,
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

export function handleEnterProductEditPage(state, action)
{
    return action.payload
}

export function handleExitProductEditPage(state, action)
{
    return initialState
}