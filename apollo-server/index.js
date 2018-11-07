const express = require('express');
const { ApolloServer, gql } = require('apollo-server-express');
const {
    GraphQLNonNull, 
    GraphQLList,
    GraphQLObjectType,
    GraphQLID,
    GraphQLString
} = require("graphql");

let people = {
    1: {
        id: 1,
        firstname: "john",
        lastname: "doe"
    }
}

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
type Query {
    getPerson(id:Int!):Person
    people(id:Int!):[Person]
}

type Mutation {
    addPerson(person:PersonInput):String
}

input PersonInput {
    id: ID!
    firstname: String
    lastname: String
}

type Person {
    id: ID!
    firstname: String
    lastname: String
}
`;


// Provide resolver functions for your schema fields
const resolvers = {
  Query: {
      getPerson(root, args, context) 
      {
          return people[args.id]
      },
      people(root, args, context) 
      {
          console.log(people)
        const ret = []
        
        Object.keys(people).forEach(key => ret.push(people[key]))
        return ret
      }
  },
  Mutation: {
      addPerson(root, args, context)
      {
          const {
              person
          } = args
          console.log(args)
          people[person.id] = person;
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