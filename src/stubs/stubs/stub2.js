import {createStub} from "../../tools"
import {enterHomePage} from "../../actions"
import stub1 from "./stub1"

const action = enterHomePage()

export default createStub(stub1, action)