import React from "react"
import PropTypes from "prop-types"
import Admin from "../body-home-page-admin"
import Customer from "../body-home-page-customer"
import Guest from "../body-home-page-guest"

export const Component =  props => {
    return <div></div>
}

Component.propTypes = {
    data: PropTypes.shape({
    }),
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {
    },
    callbacks: {
    }
}

export default Component