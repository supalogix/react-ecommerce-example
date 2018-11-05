import React from "react"

export default (Component, onEnter, onLeave) => {
    return class RoutableComponent extends React.PureComponent 
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
}


