import React from "react"

export default (onEnter, onLeave, Component) => {
    class RouteableComponent extends React.PureComponent 
    {
        componentDidMount()
        {
            onEnter()
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


