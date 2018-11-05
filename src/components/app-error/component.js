import React from "react"
import PropTypes from "prop-types"
import Header from "../header"
import Body from "../body"
import Navigation from "../navigation"

export const Component =  props => {
    return <div>
        <Header />
        <Navigation />
        <Body />
    </div>
}

Component.propTypes = {
    data: PropTypes.object,
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {},
    callbacks: {
    }
}

export default Component