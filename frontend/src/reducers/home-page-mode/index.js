import * as ActionType from "../../action-types"
import * as Mode from "../../enum-modes"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    const handlers = {
        [ActionType.FETCH_INIT_HOME_PAGE_DATA]: handleFetchInitHomePageData
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

export function handleFetchInitHomePageData(state, action)
{
    return Mode.HOME_PAGE_FETCHING_INIT_DATA
}