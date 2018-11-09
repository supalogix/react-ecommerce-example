import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"

export default ({dispatch, getState}) => next => action => {
    next(action)

    if(action.type === ActionType.ENTER_PRODUCT_EDIT_PAGE)
    {
        dispatch(Action.fetchInitEditProductPageData())

        const id = getState().productPageEditId

        getProduct(id)
            .then(result => {
                if(!result)
                {
                    // TODO: Proper Error Handling
                    dispatch(Action
                        .receiveInitEditProductPageError())
                }
                else
                {
                    dispatch(Action
                        .receiveInitEditProductPageData(
                            result))
                }
            })
    }
}


export function getProduct(id) 
{
    const query = `{
        getProduct(id: ${id})
        {
            id
            name
            description
            retailPrice
            imageUrl
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
                    resolve(response.body.data.getProduct)
                }
            })
    })
}