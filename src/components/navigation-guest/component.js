import React from "react"
import PropTypes from "prop-types"
import {
    Nav,
    NavItem
} from "../../styled-components"

export const Component = props => {
    return <Nav>
        <NavItem>Home Page</NavItem>
        <NavItem>Login</NavItem>
        <NavItem>Cart</NavItem>
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