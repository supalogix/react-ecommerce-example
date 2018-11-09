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
        desc,
        retailPrice
    }
    = state.productPageAddDataEntry


    return {
        userRole: state.userRole,
        productName,
        imageUrl,
        description: desc,
        retailPrice
    }
}

export function createCallbacks(dispatch, state)
{
    return {
        onProductNameChanged: e => dispatch(Action
            .changeProductAddField(
                "productName",
                e.currentTarget.value)),
        onImageUrlChanged: e => dispatch(Action
            .changeProductAddField(
                "imageUrl",
                e.currentTarget.value)),
        onDescriptionChanged: e => dispatch(Action
            .changeProductAddField(
                "desc",
                e.currentTarget.value)),
        onRetailPriceChanged: e => dispatch(Action
            .changeProductAddField(
                "retailPrice",
                e.currentTarget.value)),
        onSubmit: e => dispatch(Action
            .requestAddProduct())
    }
}