alias Webapp.Repo
alias Webapp.Administradores.Administrador

# Lista de administradores para serem inseridos no banco de dados
administradores = [
  %{
    nome: "João Silva",
    email: "joao.silva@example.com",
    senha: "senha123"
  },
  %{
    nome: "Maria Souza",
    email: "maria.souza@example.com",
    senha: "senha123"
  },
  %{
    nome: "Carlos Pereira",
    email: "carlos.pereira@example.com",
    senha: "senha123"
  },
  %{
    nome: "Danilo",
    email: "danilo@teste.com",
    senha: "123456"
  }
]

# Inserindo os administradores no banco de dados, verificando existência por email
for admin_params <- administradores do
  case Repo.get_by(Administrador, email: admin_params.email) do
    nil ->
      # Cria um novo administrador caso não exista
      changeset = Administrador.changeset(%Administrador{}, admin_params)
      Repo.insert!(changeset)
      IO.puts("Administrador #{admin_params.nome} criado com sucesso!")

    _existing_admin ->
      # Ignora caso o administrador já exista
      IO.puts("Administrador #{admin_params.nome} já existe, ignorando...")
  end
end

IO.puts("Processo de seed concluído!")
