import * as ActionType from "../../action-types"
import initialState from "./initial-state"

export default (state = initialState, action = {}) => {
    if(action.type === ActionType.ADD_PRODUCT_TO_CART)
    {
        return [
            ...state,
            action.payload
        ]
    }
    else
    {
        return state
    }
}