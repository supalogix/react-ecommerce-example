import React from "react"
import PropTypes from "prop-types"
import HomePage from "../body-home-page"
import LoginPage from "../body-login-page"
import ProductAddPage from "../body-product-add-page"
import ProductEditPage from "../body-product-edit-page"
import * as ActivePage from "../../enum-active-pages"

export const Component =  props => {
    const {
        activePage
    } = props.data

    switch(activePage)
    {
        case ActivePage.HOME_PAGE:
            return <HomePage />
        case ActivePage.LOGIN_PAGE:
            return <LoginPage />
        case ActivePage.PRODUCT_ADD_PAGE:
            return <ProductAddPage />
        case ActivePage.PRODUCT_EDIT_PAGE:
            return <ProductEditPage />
        default: 
            return <div>Error: No associated page for {activePage}</div>
    }
}

Component.propTypes = {
    data: PropTypes.shape({
        activePage: PropTypes.string.isRequired
    }),
    callbacks: PropTypes.shape({
    })
};

Component.defaultProps = {
    data: {
        activePage: ""
    },
    callbacks: {
    }
}

export default Component