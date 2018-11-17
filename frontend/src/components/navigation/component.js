import React from "react"
import PropTypes from "prop-types"
import Admin from "../navigation-admin"
import Customer from "../navigation-customer"
import Guest from "../navigation-guest"

export const Component = props => {
    switch(props.data.userRole)
    {
        case "admin":
            return <Admin />;
        case "customer":
            return <Customer />;
        case "guest":
            return <Guest />;
        default: 
            return <div>Error</div>
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