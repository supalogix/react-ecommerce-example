import React from "react"
import PropTypes from "prop-types"
import Admin from "../body-home-page-admin"
import Customer from "../body-home-page-customer"
import Guest from "../body-home-page-guest"

export const Component =  props => {
    const {
        userRole
    } = props.data

    switch(userRole)
    {
        case "admin":
            return <Admin />
        case "customer":
            return <Customer />
        case "guest":
            return <Guest />
        default:
            return <div>Error: could not find userRole for Body Home Page</div>
    }
}

Component.propTypes = {
    data: PropTypes.shape({
        userRole: PropTypes.string
    }),
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {
        userRole: ""
    },
    callbacks: {
    }
}

export default Component