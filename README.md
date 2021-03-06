# Webhooks

Webhook testing server - create a collection route, send webhooks to it, and inspect the messages in real time.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Running the database locally
`docker run -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 postgres`

## Testing requests

```
curl  --request POST \
  --header "Content-Type: application/json" \
  --data '{ "test":"test" }' \
  http://localhost:4000/hooks/path
```