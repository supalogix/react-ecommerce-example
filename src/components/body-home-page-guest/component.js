import React from "react"
import PropTypes from "prop-types"
import {
    Product,
    ProductName,
    ProductDescription,
    ProductPrice,
    ProductImage,
    ProductContainer,
    ProductEditLink
} from "../../styled-components"

export const Component =  props => {
    const {
        data,
        sortOrder,
        canEdit
    } = props.data

    const children = sortOrder.map(id => {
        const item = data[id]
        const Name = canEdit 
            ? () => <span>{item.name} <ProductEditLink>[edit]</ProductEditLink></span>
            : () => <span>{item.name}</span>

        return <Product>
            <ProductName><Name /></ProductName>
            <ProductPrice><strong>Price:</strong> {item.retailPrice}</ProductPrice>
            <ProductDescription><strong>Description:</strong> {item.description}</ProductDescription>
            <ProductImage> <img alt="" src={item.imageUrl} /> </ProductImage>
        </Product>
    })
    return <ProductContainer>
        {children}
    </ProductContainer>
}

Component.propTypes = {
    data: PropTypes.shape({
        data: PropTypes.object.isRequired,
        sortOrder: PropTypes.array.isRequired,
        canEdit: PropTypes.bool.isRequired
    }),
    callbacks: PropTypes.shape({
        onEditClick: PropTypes.func.isRequired
    })
};

Component.defaultProps = {
    data: {
        data: {},
        sortOrder: [],
        canEdit: false
    },
    callbacks: {
        onEditClick: () => {}
    }
}

export default Component