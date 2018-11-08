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
            onAddProductClick,
            onCartClick
        }
    } = props

    return <Nav>
        <NavItem onClick={onHomePageClick}>
            Home Page
        </NavItem>
        <NavItem onClick={onAddProductClick}>
            Add Product
        </NavItem>
    </Nav>
}

Component.propTypes = {
    data: PropTypes.object,
    callbacks: PropTypes.shape({
        onHomePageClick: PropTypes.func.isRequired,
        onAddProductClick: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {},
    callbacks: {
        onHomePageClick: () => {},
        onAddProductClick: () => {},
    }
}

export default Component