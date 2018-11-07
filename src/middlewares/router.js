import * as ActionType from "../action-types"
import * as Action from "../actions"

export default history => store => next => action => {
    next(action)

    switch(action.type)
    {
        case ActionType.VISIT_HOME_PAGE:
            history.push("/")
            break;

        case ActionType.VISIT_LOGIN_PAGE:
            history.push("/login")
            break;

        case ActionType.RECEIVE_LOGIN_OK_DATA:
            store.dispatch(Action.visitHomePage)
            break;

        default:
            break;
    }
    
}