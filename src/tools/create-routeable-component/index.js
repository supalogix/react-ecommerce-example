import React from "react"

export default (onEnter, onLeave, Component) => {
    class RouteableComponent extends React.PureComponent 
    {
        componentDidMount()
        {
            onEnter(window.location)
        }

        componentWillUnmount()
        {
            onLeave()
        }

        render()
        {
            return <Component />
        }
    }

    return <RouteableComponent />
}


