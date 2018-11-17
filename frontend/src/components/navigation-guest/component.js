import React from "react"
import PropTypes from "prop-types"
import {
    Nav,
    NavItem
} from "../../styled-components"

export const Component = props => {
    const {
        callbacks: {
            onHomePageClick,
        }
    } = props

    return <Nav>
        <NavItem onClick={onHomePageClick}>
            Home Page
        </NavItem>
    </Nav>
}

Component.propTypes = {
    data: PropTypes.object,
    callbacks: PropTypes.shape({
        onHomePageClick: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {},
    callbacks: {
        onHomePageClick: () => {},
    }
}

export default Component