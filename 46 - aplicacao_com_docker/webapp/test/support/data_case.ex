defmodule Webapp.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Webapp.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Webapp.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Webapp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Webapp.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  Helper para retornar os erros de um changeset em formato de mapa amigável.

  Exemplo:
      assert %{nome: ["não pode estar em branco"]} = errors_on(changeset)
  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
