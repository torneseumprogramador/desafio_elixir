defmodule Webapp.Release do
  @moduledoc false

  require Logger

  def create do
    load_app()

    for repo <- repos() do
      case repo.__adapter__.storage_up(repo.config) do
        :ok -> Logger.info("Banco de dados criado para #{inspect(repo)}")
        {:error, :already_up} -> Logger.info("Banco de dados já existe para #{inspect(repo)}")
        {:error, reason} -> Logger.error("Erro ao criar banco de dados para #{inspect(repo)}: #{reason}")
      end
    end
  end

  def migrate do
    load_app()

    for repo <- repos() do
      Logger.info("Rodando migrations para #{inspect(repo)}")
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def seed do
    load_app()

    for repo <- repos() do
      Logger.info("Rodando seeds para #{inspect(repo)}")
      seed_script = Path.join([priv_dir(), "repo", "seeds.exs"])

      if File.exists?(seed_script) do
        # Inicia o repositório manualmente antes de rodar o script de seed
        repo.start_link()
        Code.eval_file(seed_script)
      else
        Logger.info("Nenhum arquivo seeds.exs encontrado para #{inspect(repo)}")
      end
    end
  end

  defp repos do
    Application.fetch_env!(:webapp, :ecto_repos)
  end

  defp priv_dir do
    Application.app_dir(:webapp, "priv")
  end

  defp load_app do
    Application.load(:webapp)
  end
end
