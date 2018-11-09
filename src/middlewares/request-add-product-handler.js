import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"
import {v4} from "uuid"

export default ({dispatch, getState}) => next => action => {
    if(action.type === ActionType.REQUEST_ADD_PRODUCT)
    {
        dispatch(Action.prepareAddProductRequest())
        const {
            productName,
            imageUrl,
            desc,
            retailPrice
        } = getState().productPageAddDataEntry

        const product = {
            productName,
            imageUrl,
            desc,
            retailPrice
        }

        addProduct(product)
            .then(result => {
                if(result.isOk)
                {
                    dispatch(Action
                        .receiveAddProductOkData())
                }
                else
                {
                    dispatch(Action
                        .receiveAddProductErrorData())
                }
            })
    }

    next(action)
}


export function addProduct(p) 
{
    const id = v4()
    const product = ` {
        id: "${id}"
        name: "${p.productName}"
        description: "${p.desc}"
        imageUrl: "${p.imageUrl}"
        retailPrice: "${p.retailPrice}"
    }
    `
    const query = `mutation {
        addProduct(product: ${product})
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
                    resolve(response.body.data.addProduct)
                }
            })
    })
}