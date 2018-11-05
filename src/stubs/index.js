import stub1 from "./stubs/stub1"
import * as action from "../actions"
import {createStub} from "../tools"
//import stub2 from "./stubs/stub2"

export { stub1 }

export const stub2 = createStub(
    stub1, 
    action.enterHomePage())

export const stub3 = createStub(
    stub2,
    action.fetchInitHomePageData())

export const stub4 = createStub(
    stub3,
    action.receiveInitHomePageData({
        featuredProducts: [
            {
                productId: "0001",
                name: "Product 0001",
                description: `This is a description for 0001`,
                retailPrice: "$9.99",
                listingPrice: "$8.99",
                quantityAvailable: "1000"
            },
            {
                productId: "0002",
                name: "Product 0002",
                description: `This is a description for 0002`,
                retailPrice: "$9.99",
                listingPrice: "$8.99",
                quantityAvailable: "1000"
            },
            {
                productId: "0003",
                name: "Product 0003",
                description: `This is a description for 0003`,
                retailPrice: "$9.99",
                listingPrice: "$8.99",
                quantityAvailable: "1000"
            },
        ]
    })
)

export const stub5 = createStub(
    stub3,
    action.receiveInitHomePageError({
        message: "something bad happened"
    })
)

