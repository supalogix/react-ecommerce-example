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
        ...state.products,
        canEdit: true
    }
}

export function createCallbacks(dispatch, state)
{
    return {
        onEditClick: (productId) => () => dispatch({
            type: "EDIT_PRODUCT",
            payload: productId
        })
    }
}