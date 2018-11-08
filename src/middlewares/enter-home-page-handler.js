import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"

export default store => next => action => {
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

    next(action)
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

    return new Promise(resolve => {
        request
            .post("http://localhost:4000/graphql")
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