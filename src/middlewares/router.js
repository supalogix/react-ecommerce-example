import * as ActionType from "../action-types"
import * as Action from "../actions"

export default history => store => next => action => {
    next(action)

    switch(action.type)
    {
        case ActionType.VISIT_HOME_PAGE:
            history.push("/")
            break;

        case ActionType.LOGOUT:
            history.push("/")
            break;

        case ActionType.VISIT_LOGIN_PAGE:
            history.push("/login")
            break;

        case ActionType.VISIT_PRODUCT_ADD_PAGE:
            history.push("/product-add")
            break;

        case ActionType.VISIT_PRODUCT_EDIT_PAGE:
            const id = action.payload
            history.push(`/product-add/${id}`)
            break;

        case ActionType.RECEIVE_LOGIN_OK_DATA:
            store.dispatch(Action.visitHomePage())
            break;

        case ActionType.RECEIVE_ADD_PRODUCT_OK_DATA:
            store.dispatch(Action.visitHomePage())
            break;

        default:
            break;
    }
    
}