const app = require("./app")
const request = require("supertest")

const login = () => new Promise(resolve => {
    resolve({})
})

const addProduct = (product) => new Promise(resolve => {
    request(app)
        .post("/graphql")
        .send({
            query: `mutation {
                addProduct(product: {
                    id: ${product.id} 
                    name: ${product.name}
                    description: ${product.description} 
                    retailPrice: ${product.retailPrice}
                    imageUrl: ${product.imageUrl}
                })
            }`
        })
        .end((error, response) => {
            resolve(response.body)
        })
})

const getAllProducts = (id) => new Promise(resolve => {
    request(app)
        .post("/graphql")
        .send({
            query: `{
                products(id: ${id}) {
                    id
                    name
                    description
                    retailPrice
                    imageUrl
                }
            }`
        })
        .end((error, response) => {
            console.log(JSON.stringify(response.body, null, 3))
        })
})

const getProduct = (id) => new Promise(resolve => {
    request(app)
        .post("/graphql")
        .send({
            query: `{
                getProduct(id: ${id}) {
                    id
                    name
                    description
                    retailPrice
                    imageUrl
                }
            }`
        })
        .end((error, response) => {
            console.log(JSON.stringify(response.body, null, 3))
        })
})

//    request(app)
//        .post("/graphql")
//        .send({
//            query: `{
//                products(id: 1) {
//                    id
//                    name
//                    description
//                }
//            }`
//        })
//        .end((error, response) => {
//            console.log(JSON.stringify(response.body, null, 3))
//        })