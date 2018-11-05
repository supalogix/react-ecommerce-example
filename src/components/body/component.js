import React from "react"
import PropTypes from "prop-types"
import HomePage from "../body-home-page"

export const Component =  props => {
    switch(props.data.activePage)
    {
        case "HomePage":
            return <HomePage />
        default: 
            return <div>Error: Could Not Find Body</div>
    }
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