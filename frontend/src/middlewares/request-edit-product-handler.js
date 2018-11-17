import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"
import {v4} from "uuid"

export default ({dispatch, getState}) => next => action => {
    next(action)

    if(action.type === ActionType.REQUEST_EDIT_PRODUCT)
    {
        dispatch(Action.prepareAddProductRequest())
        const {
            id,
            productName,
            imageUrl,
            description,
            retailPrice
        } = getState().productPageEditDataEntry

        const product = {
            id,
            productName,
            imageUrl,
            description,
            retailPrice
        }

        updateProduct(product)
            .then(result => {
                if(result.isOk)
                {
                    dispatch(Action
                        .receiveEditProductOkData())
                }
                else
                {
                    dispatch(Action
                        .receiveEditProductErrorData())
                }
            })
    }

}


export function updateProduct(p) 
{
    const product = ` {
        id: "${p.id}"
        name: "${p.productName}"
        description: "${p.description}"
        imageUrl: "${p.imageUrl}"
        retailPrice: "${p.retailPrice}"
    }
    `
    const query = `mutation {
        updateProduct(product: ${product})
        {
            isOk
        }
    }`

    const url = process.env.REACT_APP_APOLLO_SERVER
    
    return new Promise(resolve => {

        request
            .post(url)
            .send({ query })
            .end((error, response) => {
                if(error)
                {
                    // TODO: Add error handling
                    resolve({
                        isOk: false
                    })
                }
                else
                {
                    resolve(response.body.data.updateProduct)
                }
            })
    })
}