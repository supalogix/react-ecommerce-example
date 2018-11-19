import express from 'express'
import { ApolloServer } from 'apollo-server-express'
import typeDefs from "./type-defs"
import resolvers from "./postgres-resolvers"
import cors from "cors"


export const server = new ApolloServer({ 
    typeDefs, 
    resolvers 
});

const app = express();
app.use(cors())
server.applyMiddleware({ app });

export default app