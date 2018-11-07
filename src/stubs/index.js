import stub1 from "./stub1"
import * as action from "../actions"
import {createStub} from "../tools"

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
                description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
                retailPrice: "$9.99",
                imageUrl: "https://via.placeholder.com/250"
            },
            {
                productId: "0002",
                name: "Product 0002",
                description: `Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
                retailPrice: "$9.99",
                imageUrl: "https://via.placeholder.com/250"
            },
            {
                productId: "0003",
                name: "Product 0003",
                description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.`,
                retailPrice: "$9.99",
                imageUrl: "https://via.placeholder.com/250"
            },
        ]
    })
)

export const stub5 = createStub(
    stub3,
    action.receiveInitHomePageError({
        message: "something bad happened"
    }))

export const stub6 = createStub(
    stub3,
    action.visitLoginPage())

export const stub7 = createStub(
    stub3,
    action.exitHomePage())

export const stub8 = createStub(
    stub3,
    action.enterLoginPage())

export const stub9 = createStub(
    stub8,
    action.changeUsername("john.doe"))

export const stub10 = createStub(
    stub9,
    action.changePassword("Qwerty!234"))

export const stub11 = createStub(
    stub10,
    action.requestLogin(
        "john.doe", 
        "Qwerty!234"))

export const stub12 = createStub(
    stub11,
    action.prepareLoginRequest())

export const stub13 = createStub(
    stub11,
    action.receiveLoginOkData({
        userRole: ""
    }))

export const stub16 = createStub(
    stub13,
    action.visitHomePage())

export const stub17 = createStub(
    stub13,
    action.exitLoginPage())

export const stub18 = createStub(
    stub13,
    action.enterHomePage())