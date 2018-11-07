const express = require('express');
const { ApolloServer, gql } = require('apollo-server-express');
const {
    GraphQLNonNull, 
    GraphQLList,
    GraphQLObjectType,
    GraphQLID,
    GraphQLString
} = require("graphql");

let products = {
    1: {
        id: "1",
        name: "Product 0001",
        description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
        retailPrice: "$9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
    2: {
        id: "2",
        name: "Product 0002",
        description: `Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
        retailPrice: "$9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
    3: {
        id: "3",
        name: "Product 0003",
        description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.`,
        retailPrice: "$9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
}

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
type Query {
    getProduct(id:Int!):Product
    products(id:Int!):[Product]
}

type Mutation {
    addProduct(product:ProductInput):String
}

input ProductInput {
    id: ID!
    name: String
    description: String
    retailPrice: String
    imageUrl: String
}

type Product {
    id: ID!
    name: String
    description: String
    retailPrice: String
    imageUrl: String
}
`;


// Provide resolver functions for your schema fields
const resolvers = {
  Query: {
      getProduct(root, args, context) 
      {
          return products[args.id]
      },
      products(root, args, context) 
      {
        const ret = []
        
        Object.keys(products).forEach(key => ret.push(products[key]))
        return ret
      }
  },
  Mutation: {
      addProduct(root, args, context)
      {
          const {
              product
          } = args
          console.log(args)
          products[product.id] = product;
      }
  }
};

const server = new ApolloServer({ typeDefs, resolvers });

const app = express();
server.applyMiddleware({ app });

const port = 4000;

app.listen({ port }, () =>
  console.log(`🚀 Server ready at http://localhost:${port}${server.graphqlPath}`),
);