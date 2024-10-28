alias Webapp.Repo
alias Webapp.Administrador

# Apagar todos os administradores existentes
Repo.delete_all(Administrador)

# Definindo administradores para serem inseridos no banco de dados com senhas
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
  }
]

# Inserindo os administradores no banco de dados com senha hash
for admin_params <- administradores do
  changeset = Administrador.changeset(%Administrador{}, admin_params)
  Repo.insert!(changeset)
end

IO.puts "Dados de administradores incluídos com sucesso!"
