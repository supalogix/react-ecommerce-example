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
    return {
        ...state.loginPageDataEntry,
        mode: state.loginPageMode
    }
}

export function createCallbacks(dispatch, state)
{
    const onUsernameChanged = e => dispatch(Action
        .changeUsername(e.currentTarget.value))
    const onPasswordChanged = e => dispatch(Action
        .changePassword(e.currentTarget.value))
    const onSubmit = () => dispatch(Action
        .requestLogin())

    return {
            onUsernameChanged,
            onPasswordChanged,
            onSubmit
    }
}