import createStore from "../create-store"

export default state =>
{
    return createStore(null, null, state);
}