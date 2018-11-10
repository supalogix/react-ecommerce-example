import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"

export default store => next => action => {
    next(action)

    if(action.type === ActionType.ENTER_HOME_PAGE)
    {
        store.dispatch(Action
            .fetchInitHomePageData())

        getAllProducts()
            .then(result => {
                store.dispatch(Action
                    .receiveInitHomePageData(
                        result.data))
            })
    }
}


export function getAllProducts() 
{
    const query = `{
        products {
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
                    resolve([])
                }
                else
                {
                    resolve(response.body)
                }
            })
    })
}