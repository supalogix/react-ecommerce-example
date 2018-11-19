const { Client } = require("pg")
const client = new Client({
    user: "user",
    host: "localhost",
    database: "postgres",
    password: "mysecretpassword"
})

client.connect()

export const saveProduct = (product) => {
}

export const updateProduct = (product) => {
}

export const getProduct = () => {

}

export const getProducts = () => {

}