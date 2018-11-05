# How to use stubs

In order to ease testing we provide stubs for application state. We generate
application state by manually simulating actions that a user might perform.
We also restrict ourselves to creating stub states by transitioning 
through actions. This is called a markov process.

Use the graphviz diagram below to document and visualize the dependencies

```graphviz
digraph finite_state_machine {
    pad = 0.25

    start -> stub1 [ label = "LOAD_APP" ]
    stub1 -> stub2 [ label = "ENTER_HOME_PAGE" ]
    stub2 -> stub3 [ label = "FETCH_INIT_HOME_PAGE_DATA" ]
    stub3 -> stub4 [ label = "RECEIVE_INIT_HOME_PAGE_DATA" ]
    stub3 -> stub5 [ label = "RECEIVE_INIT_HOME_PAGE_ERROR" ]
    stub4 -> stub6 [ label = "VISIT_LOGIN_PAGE" ]
    stub6 -> stub7 [ label = "EXIT_HOME_PAGE" ]
    stub7 -> stub8 [ label = "ENTER_LOGIN_PAGE" ]
    stub8 -> stub9 [ label = "CHANGE_USERNAME" ]
    stub9 -> stub10 [ label = "CHANGE_PASSWORD" ]
    stub10 -> stub11 [ label = "REQUEST_LOGIN" ]
    stub11 -> stub12 [ label = "SUBMIT_LOGIN_REQUEST (customer)" ]
    stub12 -> stub13 [ label = "RECEIVE_LOGIN_OK_DATA" ]
    stub12 -> stub14 [ label = "RECEIVE_LOGIN_DENIED_DATA" ]
    stub12 -> stub15 [ label = "RECEIVE_LOGIN_ERROR" ]
    stub13 -> stub16 [ label = "VISIT_HOME_PAGE" ]
    stub16 -> stub17 [ label = "EXIT_LOGIN_PAGE" ]
    stub17 -> stub18 [ label = "ENTER_HOME_PAGE" ]
    stub11 -> stub19 [ label = "SUBMIT_LOGIN_REQUEST (admin)" ]
}
```