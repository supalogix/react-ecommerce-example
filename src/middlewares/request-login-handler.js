import request from "superagent"
import * as ActionType from "../action-types"
import * as Action from "../actions"

export default store => next => action => {
    if(action.type === ActionType.REQUEST_LOGIN)
    {
        store.dispatch(Action
            .prepareLoginRequest())

        const {
            username,
            password
         } = store.getState().loginPageDataEntry

        login(username, password)
            .then(result => {
                if(result.isOk)
                {
                    store.dispatch(Action
                        .receiveLoginOkData(
                            result.userRole))
                }
                else
                {
                    store.dispatch(Action
                        .receiveLoginDeniedData())
                }
            })
    }

    next(action)
}


export function login(username, password) 
{
    const input = `{
        username: "${username}"
        password: "${password}"  
    }`

    const query = `mutation {
        login(input: ${input})
        {
            isOk,
            userRole
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
                    resolve({
                        isOk: false
                    })
                }
                else
                {
                    resolve(response.body.data.login)
                }
            })
    })
}