import { gql } from 'apollo-server-express'

export default gql`
    type Query {
        getProduct(id:Int!):Product
        products:[Product]
    }

    type Mutation {
        login(input:LoginInput):LoginResult
        addProduct(product:ProductInput):AddProductResult
        updateProduct(product:ProductInput):UpdateProductResult
    }

    input ProductInput {
        id: String!
        name: String
        description: String
        retailPrice: String
        imageUrl: String
    }

    input LoginInput {
        username: String!
        password: String!
    }

    type LoginResult {
        isOk: Boolean!
        userRole: String
    }

    type AddProductResult {
        isOk: Boolean!
    }

    type UpdateProductResult {
        isOk: Boolean!
    }

    type Product {
        id: String!
        name: String
        description: String
        retailPrice: String
        imageUrl: String
    }
`;