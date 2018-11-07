import React from "react"
import PropTypes from "prop-types"
import Admin from "../body-home-page-admin"
import Customer from "../body-home-page-customer"
import Guest from "../body-home-page-guest"

export const Component =  props => {
    const {
        data: {
            productName,
            imageUrl,
            desc,
            retailPrice,
            listingPrice,
            categories
        },
        callbacks: {
            onProductNameChanged,
            onImageUrlChanged,
            onDescriptionChanged,
            onRetailPriceChanged,
            onListingPriceChanged,
            onCategoryChanged,
        }
    } = props

    return <div>
        <div>
            <label for="productName">Product Name:</label>
            <input 
                id="productName" 
                type="text" 
                onChange={onProductNameChanged}
                defaultValue={productName} />
        </div>

        <div>
            <label for="imageUrl">Image Url:</label>
            <input 
                id="imageUrl" 
                type="text" 
                onChange={onImageUrlChanged}
                defaultValue={imageUrl} />
        </div>

        <div>
            <label for="desc">Description:</label>
            <textarea 
                onChange={onDescriptionChanged}
                rows="4" 
                cols="50">
                {desc}
            </textarea>
        </div>

        <div>
            <label for="retailPrice">Retail Price:</label>
            <input 
                id="retailPrice" 
                type="text" 
                onChange={onRetailPriceChanged}
                defaultValue={retailPrice} />
        </div>

        <div>
            <label for="listingPrice">Listing Price:</label>
            <input 
                id="listingPrice" 
                type="text" 
                onChange={onListingPriceChanged}
                defaultValue={listingPrice} />
        </div>

        <div>
            <label for="categories">Categories:</label>
            <div>
                <input type="checkbox" name="book" value="1" checked /> Boat <br />
                <input type="checkbox" name="clothing" value="2" checked /> clothing <br />
                <input type="checkbox" name="electronics" value="3" checked /> electronics <br />
            </div>
        </div>

        <div> Submit </div>
    </div>

}

Component.propTypes = {
    data: PropTypes.shape({
        productName: PropTypes.string.isRequired,
        imageUrl: PropTypes.string.isRequired,
        desc: PropTypes.string.isRequired,
        retailPrice: PropTypes.string.isRequired,
        listingPrice: PropTypes.string.isRequired,
        categories: PropTypes.array.isRequired 
    }),
    callbacks: PropTypes.shape({
        onProductNameChanged: PropTypes.func.isRequired,
        onImageUrlChanged: PropTypes.func.isRequired,
        onDescriptionChanged: PropTypes.func.isRequired,
        onRetailPriceChanged: PropTypes.func.isRequired,
        onListingPriceChanged: PropTypes.func.isRequired,
        onCategoryChanged: PropTypes.func.isRequired,
    })
};

Component.defaultProps = {
    data: {
        productName: "",
        imageUrl: "",
        desc: "",
        retailPrice: "",
        listingPrice: "",
        categories: [
            {
                name: "option1",
                value: "1",
                text: "Some Option",
                isChecked: true
            }
        ]
    },
    callbacks: {
        onProductNameChanged: () => {},
        onImageUrlChanged: () => {},
        onDescriptionChanged: () => {},
        onRetailPriceChanged: () => {}, 
        onListingPriceChanged: () => {},
        onCategoryChanged: () => {}
    }
}

export default Component