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
        canEdit: state.userRole === "admin"
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