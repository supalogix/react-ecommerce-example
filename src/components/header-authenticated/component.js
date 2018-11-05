import React from "react"
import PropTypes from "prop-types"

export const Header =  props => {
    return <div>
        <div>Site Name</div>
        <div>Hello Authenticated</div>
    </div>
}

Header.propTypes = {
    data: PropTypes.array,
    callbacks: PropTypes.shape({
        onClick: PropTypes.func.isRequired
    })
};

Header.defaultProps = {
    data: [],
    callbacks: {
        onClick: () => {}
    }
}

export default Header