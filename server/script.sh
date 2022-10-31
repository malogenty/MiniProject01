#!/bin/bash
mix ecto.drop
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds/user_seeds.exs
mix run priv/repo/seeds/working_time_seeds.exs
mix run priv/repo/seeds/clocks_seeds.exs
mix run priv/repo/seeds/hours_worked_seeds.exs