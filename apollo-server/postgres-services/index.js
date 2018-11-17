const { Client } = require("pg")
const client = new Client({
    user: "user",
    host: "localhost",
    database: "postgres",
    password: "mysecretpassword"
})

client.connect()

module.exports.save = () => {

}