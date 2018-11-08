import React from "react"
import PropTypes from "prop-types"
import * as MODE from "../../enum-modes"
import {
    EditForm,
    EditField,
    EditLabel,
    EditInput,
    EditButton
} from "../../styled-components"

export const Component =  props => {
    switch(props.data.mode)
    {
        case MODE.LOGIN_PAGE_READY:
            return <ValidForm {...props} />
        case MODE.LOGIN_PAGE_SHOWING_ERRORS:
            return <div>Todo: Login Error Page</div>
        case MODE.LOGIN_PAGE_WAITING:
            return <div>Waiting ...</div>
        default:
            return <div>
                Error: body-login-page-guest could not find a valid renderer
            </div>
    }
}

Component.propTypes = {
    data: PropTypes.shape({
        mode: PropTypes.string.isRequired,
        formErrors: PropTypes.string.isRequired,
        username: PropTypes.string.isRequired,
        password: PropTypes.string.isRequired
    }),
    callbacks: PropTypes.shape({
        onUsernameChanged: PropTypes.func.isRequired,
        onPasswordChanged: PropTypes.func.isRequired,
        onSubmit: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {
        username: "override me",
        password: "override me"
    },
    callbacks: {
        onUsernameChanged: () => console.log("override me"),
        onPasswordChanged: () => console.log("override me"),
        onSubmit: () => console.log("override me"),
    }
}

export default Component

export function ValidForm(props)
{
    const {
        data: {
            username,
            password
        },
        callbacks: {
            onUsernameChanged,
            onPasswordChanged,
            onSubmit
        }
    } = props

    return <EditForm>
        <EditField>
            <EditLabel>
                Username:
            </EditLabel>
            <EditInput>
                <input 
                    type="text" 
                    defaultValue={username}
                    onChange={onUsernameChanged}
                />
            </EditInput>
        </EditField>
        <EditField>
            <EditLabel>
                Password:
            </EditLabel>
            <EditInput>
                <input 
                    type="text" 
                    defaultValue={password}
                    onChange={onPasswordChanged} 
                />
            </EditInput>
        </EditField>
        <EditButton onClick={onSubmit}>Submit</EditButton>
    </EditForm>
}