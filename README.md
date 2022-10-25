# ApiProject

Create user in PostgreSQL:  
  ``CREATE ROLE miniapiproject WITH LOGIN PASSWORD 'password';  
  ALTER ROLE miniapiproject CREATEDB;
  ``

Into the database (\connect miniproject01_dev):
```
GRANT SELECT, UPDATE, INSERT, DELETE ON users TO miniapiproject;
GRANT SELECT, UPDATE, INSERT, DELETE ON clocks TO miniapiproject;
GRANT SELECT, UPDATE, INSERT, DELETE ON workingtimes TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE clocks_id_seq TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE workingtimes_id_seq TO miniapiproject;
```


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
