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
        ...state.productPageEditDataEntry,
        userRole: state.userRole
    }
}

export function createCallbacks(dispatch, state)
{
    return {
        onProductNameChanged: e => dispatch(Action
            .changeProductEditField(
                "productName",
                e.currentTarget.value)),
        onImageUrlChanged: e => dispatch(Action
            .changeProductEditField(
                "imageUrl",
                e.currentTarget.value)),
        onDescriptionChanged: e => dispatch(Action
            .changeProductEditField(
                "description",
                e.currentTarget.value)),
        onRetailPriceChanged: e => dispatch(Action
            .changeProductEditField(
                "retailPrice",
                e.currentTarget.value)),
        onSubmit: e => dispatch(Action
            .requestEditProduct())
    }
}