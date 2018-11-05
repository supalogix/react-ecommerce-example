import React from "react"
import PropTypes from "prop-types"

export const Component =  props => {
    return <div>
        Body Home Page Customer
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