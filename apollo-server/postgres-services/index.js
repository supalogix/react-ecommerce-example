const { Client } = require("pg")
const client = new Client({
    user: "user",
    host: "localhost",
    database: "postgres",
    password: "mysecretpassword"
})

client.connect()

export const saveProduct = (product) => {
    const sql = `
        INSERT INTO dbo.lpr_product
        (
            
        )
        VALUES
        (

        )
    `
}

export const updateProduct = (product) => {
    const sql = `
        INSERT INTO dbo.lpr_product
        (

        )
        VALUES
        (

        )
    `
}

export const getProduct = () => {
    const sql = `
    `
}

export const getProducts = () => {
    const sql = `
    `
}