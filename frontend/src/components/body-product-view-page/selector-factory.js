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
    }
}

export function createCallbacks(dispatch, state)
{
    return {
    }
}