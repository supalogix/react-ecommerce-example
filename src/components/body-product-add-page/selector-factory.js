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
    const {
        productName,
        imageUrl,
        description,
        retailPrice
    }
    = state.productPageAddDataEntry


    return {
        userRole: state.userRole,
        productName,
        imageUrl,
        description,
        retailPrice
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
                "desc",
                e.currentTarget.value)),
        onRetailPriceChanged: e => dispatch(Action
            .changeProductEditField(
                "retailPrice",
                e.currentTarget.value)),
        onSubmit: e => dispatch(Action
            .requestAddProduct())
    }
}