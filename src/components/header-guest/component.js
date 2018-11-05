import React from "react"
import PropTypes from "prop-types"
import {
    Header,
    HeaderLeft,
    HeaderRight
} from "../../styled-components"

export const Component =  props => {
    return <Header>
        <HeaderLeft>Site Name</HeaderLeft>
        <HeaderRight>Hello Guest</HeaderRight>
    </Header>
}

Component.propTypes = {
    data: PropTypes.array,
    callbacks: PropTypes.shape({
        onClick: PropTypes.func.isRequired
    })
};

Component.defaultProps = {
    data: [],
    callbacks: {
        onClick: () => {}
    }
}

export default Component