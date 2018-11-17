const getProduct = require("./query/get-product")
const products = require("./query/products")
const login = require("./mutation/login")
const addProduct = require("./mutation/add-product")
const updateProduct = require("./mutation/update-product")

const resolvers = {
  Query: {
    getProduct,
    products
  },
  Mutation: {
    login,
    addProduct,
    updateProduct
  }
};

module.exports = resolvers;