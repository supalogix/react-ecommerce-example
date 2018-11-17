import React from "react"
import PropTypes from "prop-types"
import {
    Nav,
    NavItem
} from "../../styled-components"

export const Component =  props => {
    const {
        callbacks: {
            onHomePageClick,
            onLoginPageClick,
            onCartClick
        }
    } = props

    return <Nav>
        <NavItem onClick={onHomePageClick}>
            Home Page
        </NavItem>
        <NavItem onClick={onLoginPageClick}>
            Logout
        </NavItem>
        <NavItem onClick={onCartClick}>
            Cart
        </NavItem>
    </Nav>
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