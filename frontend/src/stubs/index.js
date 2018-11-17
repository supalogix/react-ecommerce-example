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
        "products": [
            {
              "id": "1",
              "name": "Product 0001",
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
            {
              "id": "2",
              "name": "Product 0002",
              "description": "Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
            {
              "id": "3",
              "name": "Product 0003a",
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
          ]
        }))

export const stub6 = createStub(
    stub4,
    action.visitLoginPage())

export const stub7 = createStub(
    stub6,
    action.exitHomePage())

export const stub8 = createStub(
    stub7,
    action.enterLoginPage())

export const stub9 = createStub(
    stub8,
    action.changeUsername("john.doe"))

export const stub10 = createStub(
    stub9,
    action.changePassword("Qwerty!234"))

export const stub11 = createStub(
    stub10,
    action.requestLogin())

export const stub12 = createStub(
    stub11,
    action.prepareLoginRequest())

export const stub13 = createStub(
    stub12,
    action.receiveLoginOkData("admin"))

export const stub16 = createStub(
    stub13,
    action.visitHomePage())

export const stub17 = createStub(
    stub16,
    action.exitLoginPage())

export const stub18 = createStub(
    stub17,
    action.enterHomePage())

export const stub19 = createStub(
    stub18,
    action.fetchInitHomePageData())

export const stub20 = createStub(
    stub19,
    action.receiveInitHomePageData({
        "products": [
            {
              "id": "1",
              "name": "Product 0001",
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
            {
              "id": "2",
              "name": "Product 0002",
              "description": "Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
            {
              "id": "3",
              "name": "Product 0003a",
              "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.",
              "retailPrice": "9.99",
              "imageUrl": "https://via.placeholder.com/250"
            },
          ]
        }))

export const stub21 = createStub(
    stub20,
    action.editProduct("1"))

export const stub22 = createStub(
    stub21,
    action.exitHomePage())

export const stub23 = createStub(
    stub22,
    action.enterProductEditPage("1"))

export const stub24 = createStub(
    stub23,
    action.fetchInitEditProductPageData())

export const stub25 = createStub(
    stub24,
    action.receiveInitEditProductPageData({
        "id": "1",
        "name": "Product 0001",
        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
        "retailPrice": "9.99",
        "imageUrl": "https://via.placeholder.com/250"
    }))

export const stub26 = createStub(
    stub25,
    action.changeProductEditField("productName", "Product 0001 New"))

export const stub27 = createStub(
    stub26,
    action.changeProductEditField("description", "This is a description"))

export const stub28 = createStub(
    stub20,
    action.visitProductAddPage())

export const stub29 = createStub(
    stub28,
    action.exitHomePage())

export const stub30 = createStub(
    stub29,
    action.enterProductAddPage())

export const stub31 = createStub(
    stub30,
    action.changeProductAddField("productName", "New Product"))

export const stub32 = createStub(
    stub31,
    action.changeProductAddField("desc", "This is a description"))

export const stub33 = createStub(
    stub32,
    action.changeProductAddField("imageUrl", "https://via.placeholder.com/250"))

export const stub34 = createStub(
    stub33,
    action.changeProductAddField("retailPrice", "9.99"))