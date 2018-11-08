import React from "react"
import PropTypes from "prop-types"
import {
    EditForm,
    EditField,
    EditLabel,
    EditInput,
    EditButton
} from "../../styled-components"
import * as Role from "../../enum-roles"

export const Component =  props => {
    const {
        data: {
            userRole,
            productName,
            imageUrl,
            description,
            retailPrice,
        },
        callbacks: {
            onProductNameChanged,
            onImageUrlChanged,
            onDescriptionChanged,
            onRetailPriceChanged,
            onSubmit,
        }
    } = props

    if(userRole === Role.GUEST)
        return <div>You are not authorized to view this page</div>

    return <EditForm>
        <EditField>
            <EditLabel>
                <label for="productName">
                    Product Name:
                </label>
            </EditLabel>
            <EditInput>
                <input 
                    id="productName" 
                    type="text" 
                    onChange={onProductNameChanged}
                    defaultValue={productName} />
            </EditInput>
        </EditField>

        <EditField>
            <EditLabel>
                <label for="imageUrl">
                    Image Url:
                </label>
            </EditLabel>
            <EditInput>
                <input 
                    id="imageUrl" 
                    type="text" 
                    onChange={onImageUrlChanged}
                    defaultValue={imageUrl} />
            </EditInput>
        </EditField>

        <EditField>
            <EditLabel>
                <label for="desc">
                    Description:
                </label>
            </EditLabel>
            <EditInput>
                <textarea 
                    onChange={onDescriptionChanged}
                    rows="4" 
                    cols="50">
                    {description}
                </textarea>
            </EditInput>
        </EditField>

        <EditField>
            <EditLabel>
                <label for="retailPrice">
                    Retail Price:
                </label>
            </EditLabel>
            <EditInput>
                <input 
                    id="retailPrice" 
                    type="text" 
                    onChange={onRetailPriceChanged}
                    defaultValue={retailPrice} />
            </EditInput>
        </EditField>

        <EditButton onClick={onSubmit}> Submit </EditButton>
    </EditForm>

}

Component.propTypes = {
    data: PropTypes.shape({
        userRole: PropTypes.string.isRequired,
        productName: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        description: PropTypes.string.isRequired,
        retailPrice: PropTypes.string.isRequired,
    }),
    callbacks: PropTypes.shape({
        onProductNameChanged: PropTypes.func.isRequired,
        onImageUrlChanged: PropTypes.func.isRequired,
        onDescriptionChanged: PropTypes.func.isRequired,
        onRetailPriceChanged: PropTypes.func.isRequired,
        onListingPriceChanged: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {
        userRole: "override me",
        productName: "override me",
        imageUrl: "override me",
        description: "override me",
        retailPrice: "override me",
    },
    callbacks: {
        onProductNameChanged: () => console.log("override me"),
        onImageUrlChanged: () => console.log("override me"),
        onDescriptionChanged:() => console.log("override me"),
        onRetailPriceChanged: () => console.log("override me"),
        onSubmit: () => console.log("override me"),
    }
}

export default Component