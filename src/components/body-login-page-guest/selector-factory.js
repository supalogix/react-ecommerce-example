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
        ...state.homePageDataEntry
    }
}

export function createCallbacks(dispatch, state)
{
    return {
    }
}