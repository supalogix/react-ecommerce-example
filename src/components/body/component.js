import React from "react"
import PropTypes from "prop-types"
import HomePage from "../body-home-page"
import LoginPage from "../body-login-page"
import * as ActivePage from "../../enum-active-pages"

export const Component =  props => {
    switch(props.data.activePage)
    {
        case ActivePage.HOME_PAGE:
            return <HomePage />
        case ActivePage.LOGIN_PAGE:
            return <LoginPage />
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