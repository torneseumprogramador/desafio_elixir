defmodule WebappWeb.AdministradorFormComponent do
  use Phoenix.Component

  def administrador_form(assigns) do
    ~H"""
    <form action={if assigns[:path] && @path, do: @path, else: ""} method="post">
        <!-- Campo Nome -->
        <div class="mb-3">
            <label for="nome" class="form-label">Nome</label>
            <input type="text" class="form-control" id="nome" value={if assigns[:administrador] && @administrador, do: @administrador.nome, else: ""} name="nome" placeholder="Digite o nome" >
        </div>

        <!-- Campo Email -->
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" value={if assigns[:administrador] && @administrador, do: @administrador.email, else: ""} name="email" placeholder="Digite o email" >
        </div>

        <!-- Campo Senha -->
        <div class="mb-3">
            <label for="senha" class="form-label">Senha</label>
            <input type="password" class="form-control" id="senha" value={if assigns[:administrador] && @administrador, do: @administrador.senha, else: ""} name="senha" placeholder="Digite a senha" >
        </div>

        <!-- Botão de Enviar -->

        <%= if assigns[:changeset] && @changeset && @changeset.errors != [] do %>
            <div class="text-danger">
            <strong>Erro ao cadastrar:</strong>
            <ul>
                <%= for {field, {msg, _}} <- @changeset.errors do %>
                <li><%= "#{String.capitalize(to_string(field))}: #{msg}" %></li>
                <% end %>
            </ul>
            </div>
        <% end %>


        <button type="submit" class="btn btn-primary">Enviar</button>
        <input type="hidden" name="_csrf_token" value={Plug.CSRFProtection.get_csrf_token()}>
    </form>
    """
  end
end
