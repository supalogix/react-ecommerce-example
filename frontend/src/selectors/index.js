import {createSelector} from "reselect"

export const userRole = state => state.userRole

export const isAuthenticated = createSelector(
    userRole,
    userRole => {
        switch(userRole)
        {
            case "admin":
            case "customer":
                return true;
            default:
                return false;
        }
    })