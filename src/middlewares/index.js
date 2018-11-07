import routerMw from "./router"

export default history => ([
    routerMw(history)
])