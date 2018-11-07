import * as Stub from "../stubs"
import {expect} from "chai"
import * as Mode from "../enum-modes"
import * as ActivePage from "../enum-active-pages"

it("stub2", () => {
    expect(Stub.stub2.activePage).to.equal(ActivePage.HOME_PAGE)
})

it("stub3", () => {
    const state = Stub.stub3;

    expect(Stub.stub2.activePage).to.equal(ActivePage.HOME_PAGE)
    expect(state.homePageMode).to.equal(Mode.HOME_PAGE_FETCHING_INIT_DATA)
})

it("stub8", () => {
    const state = Stub.stub8;

    expect(state.activePage).to.equal(ActivePage.LOGIN_PAGE)
})