import Header from "./component"
import selectorFactory from "./selector-factory"
import {connectAdvanced} from "react-redux"

export default connectAdvanced(selectorFactory)(Header)