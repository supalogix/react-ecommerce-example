import React from "react"
import PropTypes from "prop-types"

export const Component =  props => {
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

    return <div>
        <div>
            <div>Username:</div>
            <div>
                <input 
                    type="text" 
                    defaultValue={username}
                    onChange={onUsernameChanged}
                />
            </div>
        </div>
        <div>
            <div>Password:</div>
            <div>
                <input 
                    type="text" 
                    defaultValue={password}
                    onChange={onPasswordChanged} 
                />
            </div>
        </div>
        <div onClick={onSubmit}>Submit</div>
    </div>
}

Component.propTypes = {
    data: PropTypes.shape({
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
        username: "",
        password: ""
    },
    callbacks: {
        onUsernameChanged: () => {},
        onPasswordChanged: () => {},
        onSubmit: () => {}
    }
}

export default Component