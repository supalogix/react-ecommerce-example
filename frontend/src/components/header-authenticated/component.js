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
            onClick
        }
    } = props

    return <Header>
        <HeaderLeft>Site Name</HeaderLeft>
        <HeaderRight>
            <HeaderButton onClick={onClick}>Logout</HeaderButton>
        </HeaderRight>
    </Header>
}

Component.propTypes = {
    data: PropTypes.shape({}),
    callbacks: PropTypes.shape({
        onClick: PropTypes.func.isRequired
    })
};

Component.defaultProps = {
    data: {},
    callbacks: {
        onClick: () => console.log("override me"),
    }
}

export default Component