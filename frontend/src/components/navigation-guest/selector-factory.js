import * as Action from "../../actions"

export default dispatch => state => {
    const data = createData(state)
    const callbacks = createCallbacks(dispatch, state)

    return {
        data,
        callbacks
    }
}

export function createData(state)
{
    return state
}

export function createCallbacks(dispatch, state)
{
    return {
        onHomePageClick: () => dispatch(Action.visitHomePage()),
        onLoginClick: () => dispatch(Action.visitLoginPage()),
        onCartClick: () => dispatch(Action.visitCartPage()),
    }
}