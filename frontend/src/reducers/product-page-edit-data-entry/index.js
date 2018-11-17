import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.EXIT_PRODUCT_EDIT_PAGE]: handleExitLoginPage,
        [ActionType.RECEIVE_INIT_EDIT_PRODUCT_PAGE_DATA]: handleReceiveInitEditProductPageData,
        [ActionType.CHANGE_PRODUCT_EDIT_FIELD]: handleChangeProductEditField
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

export function handleChangeProductEditField(state, action)
{
    return {
        ...state,
        [action.payload.name]: action.payload.value
    }
}

export function handleReceiveInitEditProductPageData(state, action)
{
    const {
        id,
        name,
        imageUrl,
        description,
        retailPrice
    } = action.payload

    return {
        id,
        productName: name,
        imageUrl,
        description,
        retailPrice
    }
}
