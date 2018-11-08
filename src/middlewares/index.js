import routerMw from "./router"
import enterHomePageHandler from "./enter-home-page-handler"

export default history => ([
    routerMw(history),
])

export {
    enterHomePageHandler
}