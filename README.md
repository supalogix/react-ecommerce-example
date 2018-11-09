# How to use "React Ecommerce Example" for run and profit

This is a simple react app that demonstrates basic features of an ecommerce platform.

The following features exist
 * view products on a home page
 * login as an admin
 * edit product info as an admin
 * add a new product as an admin
 * logout

No validation exists to simplify the source code

With the following commands you can (a) install, (b) build, and (c) serve the frontend app

```bash
yarn install
yarn start
```

You will also need to start the graphql server too make the frontend app work. You can do that with

```bash
node apoollo-server/index.js
```

Alternatively, if you have docker installed then you can use docker compose to run a continerized versiono

```bash
docker-compose up -d
```

We setup the docker-compose.yml file to map to the local machine's 3000 and 4000 port. Ensure that that port is available

You can run the tests with the following command

```bash
yarn install
yarn test
```

We follow a type of acceptance test driven development:
 * define a requirement
 * create a stub that simulates inputs for the requirement
 * create failing test case that uses the stubbed input
 * pass the failing test case

 You can run the storybook with the following command

 ```bash
yarn storybook
 ```

 We use the storybook to visualize different states of the application without having to run the application. This allows us to build the frontend of the application without concern of the backend. Using this approach you can quickly prototype different versions of the frontend and only code the backend once you have a UI/UX you like.
