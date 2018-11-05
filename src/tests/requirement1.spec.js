import * as Stub from "../stubs"
import {expect} from "chai"

it("stub2", () => {
    expect(Stub.stub2.activePage).to.equal("HomePage")
})

it("stub3", () => {
    const state = Stub.stub3;

    expect(state.activePage).to.equal("HomePage")
})