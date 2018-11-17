import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.EXIT_PRODUCT_ADD_PAGE]: handleExitLoginPage,
        [ActionType.CHANGE_PRODUCT_ADD_FIELD]: handleChangeProductAddField
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

export function handleExitLoginPage(state, action)
{
    return initialState
}

export function handleChangeProductAddField(state, action)
{
    return {
        ...state,
        [action.payload.name]: action.payload.value
    }
}

