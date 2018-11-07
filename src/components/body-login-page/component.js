import React from "react"
import PropTypes from "prop-types"
import * as ActivePage from "../../enum-active-pages"
import Guest from "../body-login-page-guest"

export const Component =  props => {
    const {
        userRole
    } = props.data

    switch(userRole)
    {
        case "guest":
            return <Guest />

        default:
            return <div>Error: could not find userRole for Body Home Page</div>
    }
}

Component.propTypes = {
    data: PropTypes.shape({
        userRole: PropTypes.string.isRequired
    }),
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {
        userRole: "",
    },
    callbacks: {
    }
}

export default Component