import React from "react"
import PropTypes from "prop-types"
import {
    Header,
    HeaderLeft,
    HeaderRight,
    HeaderButton,
} from "../../styled-components"

export const Component = props => {
    const {
        callbacks: {
            onLoginClick,
        }
    } = props

    return <Header>
        <HeaderLeft>Site Name</HeaderLeft>
        <HeaderRight>
            <HeaderButton onClick={onLoginClick}>Login</HeaderButton>
        </HeaderRight>
    </Header>
}

Component.propTypes = {
    data: PropTypes.object,
    callbacks: PropTypes.shape({
        onLoginClick: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {},
    callbacks: {
        onLoginClick: () => console.log("override me"),
    }
}

export default Component