defmodule WebappWeb.Controllers.Api.AdminController do
  use WebappWeb, :controller
  alias Webapp.Administradores
  # alias Webapp.JWTConfig

  def index(conn, params=%{}) do
    q = Map.get(params, "q", nil)
    pagina = Map.get(params, "pagina", "1") |> String.to_integer()
    administradores_paginado = Administradores.list_administradores_by_nome_or_email_paginado(q, 5, pagina)
    json(conn, administradores_paginado)
  end

  def get(conn, %{"id" => id}) do
    try do
      administrador = Administradores.get_administrador!(id)
      json(conn, administrador)
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Administrador não encontrado"})
    end
  end

  def create(conn, %{"nome" => nome, "email" => email, "senha" => senha}) do
    attrs = %{"nome" => nome, "email" => email, "senha" => senha}

    case Administradores.create_administrador(attrs) do
      {:ok, administrador} ->
        conn
        |> put_status(:created)
        |> json(administrador)

      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def update(conn, %{"id" => id} = params) do
    try do
      administrador = Administradores.get_administrador!(id)
      case Administradores.update_administrador(administrador, params) do
        {:ok, administrador} ->
          conn
          |> put_status(:ok)
          |> json(administrador)
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:bad_request)
          |> json(changeset)
      end
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Administrador não encontrado"})
    end
  end

  def delete(conn, %{"id" => id}) do
    case Administradores.delete_administrador_by_id(id) do
      {:ok, _administrador} ->
        conn
        |> put_status(:no_content)
        |> json(%{})
      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Administrador não encontrado"})
    end
  end
end
