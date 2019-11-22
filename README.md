# Jobber

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## GraphQL

`absinthe` is the core package that implements the GraphQL spec. Simply put, it knows how to transform a GraphQL document and a schema into a JSON result. However, it’s not concerned with how GraphQL documents are transported. That’s where the other two specialized packages come in. The `absinthe_plug` handles GraphQL documents sent over HTTP to a Phoenix endpoint. And the `absinthe_phoenix` package supports GraphQL subscriptions over Phoenix channels.

---

## Resolvers

Resolvers are 3-arity functions. Most of the time all you care about is the second argument which is a map of query arguments. Remember, the place query takes an id argument, so we pattern match the second argument to get the id.
