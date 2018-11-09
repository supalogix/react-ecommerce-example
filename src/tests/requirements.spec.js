import * as Stub from "../stubs"
import {expect} from "chai"
import * as Mode from "../enum-modes"
import * as Role from "../enum-roles"
import * as ActivePage from "../enum-active-pages"

it("stub2", () => {
    const state = Stub.stub2;

    expect(state.activePage).to.equal(ActivePage.HOME_PAGE)
    expect(state.userRole).to.equal(Role.GUEST)
})

it("stub4", () => {
    const state = Stub.stub4;

    const expected = {
        "data": {
          "1": {
            "id": "1",
            "name": "Product 0001",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
            "retailPrice": "9.99",
            "imageUrl": "https://via.placeholder.com/250"
          },
          "2": {
            "id": "2",
            "name": "Product 0002",
            "description": "Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
            "retailPrice": "9.99",
            "imageUrl": "https://via.placeholder.com/250"
          },
          "3": {
            "id": "3",
            "name": "Product 0003a",
            "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.",
            "retailPrice": "9.99",
            "imageUrl": "https://via.placeholder.com/250"
          }
        },
        "sortOrder": [
          "1",
          "2",
          "3"
        ]
    }

    expect(state.products).to.deep.equal(expected)
})

it("stub8", () => {
    const state = Stub.stub8;
    const {
        username,
        password
    } = state.loginPageDataEntry

    expect(state.activePage).to.equal(ActivePage.LOGIN_PAGE)
    expect(state.userRole).to.equal(Role.GUEST)
    expect(username).to.equal("")
    expect(password).to.equal("")
})

it("stub9", () => {
    const state = Stub.stub9;
    const {
        username,
        password
    } = state.loginPageDataEntry

    expect(username).to.equal("john.doe")
    expect(password).to.equal("")
})

it("stub10", () => {
    const state = Stub.stub10;
    const {
        username,
        password
    } = state.loginPageDataEntry

    expect(username).to.equal("john.doe")
    expect(password).to.equal("Qwerty!234")
})

it("stub18", () => {
    const state = Stub.stub18;

    expect(state.activePage).to.equal(ActivePage.HOME_PAGE)
    expect(state.homePageMode).to.equal(Mode.HOME_PAGE_FETCHING_INIT_DATA)
    expect(state.userRole).to.equal(Role.ADMIN)
})

it("stub23", () => {
    const state = Stub.stub23;

    expect(state.activePage).to.equal(ActivePage.PRODUCT_EDIT_PAGE)
    expect(state.userRole).to.equal(Role.ADMIN)
    expect(state.productPageEditId).to.equal("1")
})

it("stub25", () => {
    const state = Stub.stub25;

    const expected = {
        id: "1",
        productName: "Product 0001",
        imageUrl: "https://via.placeholder.com/250",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
        retailPrice: "9.99"
    }

    expect(state.productPageEditDataEntry).to.deep.equal(expected)
})

it("stub26", () => {
    const state = Stub.stub26;

    const expected = {
        id: "1",
        productName: "Product 0001 New",
        imageUrl: "https://via.placeholder.com/250",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. ",
        retailPrice: "9.99"
    }

    expect(state.productPageEditDataEntry).to.deep.equal(expected)
})

it("stub27", () => {
    const state = Stub.stub27;

    const expected = {
        id: "1",
        productName: "Product 0001 New",
        imageUrl: "https://via.placeholder.com/250",
        description: "This is a description",
        retailPrice: "9.99"
    }

    expect(state.productPageEditDataEntry).to.deep.equal(expected)
})


it("stub30", () => {
    const state = Stub.stub30;

    expect(state.activePage).to.equal(ActivePage.PRODUCT_ADD_PAGE)
    expect(state.userRole).to.equal(Role.ADMIN)
})

it("stub31", () => {
    const state = Stub.stub31;

    const expected = {
        productName: "New Product",
        imageUrl: "",
        desc: "",
        retailPrice: ""
    } 

    expect(state.productPageAddDataEntry).to.deep.equal(expected)
})

it("stub32", () => {
    const state = Stub.stub32;

    const expected = {
        productName: "New Product",
        imageUrl: "",
        desc: "This is a description",
        retailPrice: ""
    } 

    expect(state.productPageAddDataEntry).to.deep.equal(expected)
})

it("stub33", () => {
    const state = Stub.stub33;

    const expected = {
        productName: "New Product",
        imageUrl: 'https://via.placeholder.com/250',
        desc: "This is a description",
        retailPrice: ""
    } 

    expect(state.productPageAddDataEntry).to.deep.equal(expected)
})