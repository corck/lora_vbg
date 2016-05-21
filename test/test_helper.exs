ExUnit.start

Mix.Task.run "ecto.create", ~w(-r LoraVbg.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r LoraVbg.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(LoraVbg.Repo)

