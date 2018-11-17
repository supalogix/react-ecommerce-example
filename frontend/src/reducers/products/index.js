import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.RECEIVE_INIT_HOME_PAGE_DATA]: 
            handleReceiveInitHomePageData
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

export function handleReceiveInitHomePageData(state, action)
{
    let data = {}
    action.payload.products.forEach(item => {
        data[item.id] = item;
    })

    const sortOrder = Object.keys(data)

    return {
        data: {
            ...state.data,
            ...data
        },
        sortOrder
    }
}