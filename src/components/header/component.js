import React from "react"
import PropTypes from "prop-types"
import Authenticated from "../header-authenticated"
import Guest from "../header-guest"

export const Component =  props => {
    const {
        isAuthenticated
    } = props.data

    if(isAuthenticated)
    {
        return <Authenticated />
    }
    else
    {
        return <Guest />
    }
}

Component.propTypes = {
    data: PropTypes.shape({
        isAuthenticated: PropTypes.bool
    }),
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {
        isAuthenticated: false
    },
    callbacks: {
        onClick: () => {}
    }
}

export default Component