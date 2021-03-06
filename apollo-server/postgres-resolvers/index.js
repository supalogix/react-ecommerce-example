let products = {
    "1": {
        id: "1",
        name: "Product 0001",
        description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
        retailPrice: "9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
    "2": {
        id: "2",
        name: "Product 0002",
        description: `Sed consectetur lorem erat, at semper nisi porta in. Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi. Fusce rhoncus purus sed vestibulum vehicula. `,
        retailPrice: "9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
    "3": {
        id: "3",
        name: "Product 0003",
        description: `Lorem ipsum dolor sit amet, consectetur adipiscing elit Proin lorem leo, fringilla eu lectus ac, interdum sagittis mi.`,
        retailPrice: "9.99",
        imageUrl: "https://via.placeholder.com/250"
    },
}

export default ({
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
      login(root, args, context)
      {
        const {
            input: {
                username,
                password
            }
        } = args

        const isValid = username === "john.doe"
            && password === "Qwerty!234"
        
        if(isValid)
        {
            return {
                isOk: true,
                userRole: "admin"
            }
        }
        else
        {
            return {
                isOk: false
            }
        }
      },
      addProduct(root, args, context)
      {
          const {
              product
          } = args

          if(product.id in products)
          {
              // @TODO: add error messages
              return {
                  isOk: false
              }
          }
          else
          {
            products[product.id] = product;

            return {
                isOk: true
            }
          }
      },
      updateProduct(root, args, context)
      {
          const {
              product
          } = args

          if(product.id in products)
          {
            products[product.id] = product;

            return {
                isOk: true
            }
          }
          else
          {
              // @TODO: add error messages
              return {
                  isOk: false
              }
          }
      }
  }
})