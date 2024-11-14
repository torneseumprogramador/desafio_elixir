defmodule WebappWeb.Router do
  use WebappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WebappWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug WebappWeb.Components.Middleware.AuthMiddleware
  end

  pipeline :api_authenticated do
    plug WebappWeb.Components.Middleware.ApiAuthMiddleware
  end

  scope "/api", WebappWeb.Controllers.Api do
    pipe_through :api

    get "/", HomeController, :index
    post "/login", LoginController, :login

    scope "/" do
      pipe_through :api_authenticated
      get "/refresh_token", LoginController, :new_token

      get "/administradores", AdminController, :index
      get "/administradores/:id", AdminController, :get
      post "/administradores", AdminController, :create
      put "/administradores/:id", AdminController, :update
      delete "/administradores/:id", AdminController, :delete

      get "/produtos", ProdutoController, :index
      get "/produtos/:id", ProdutoController, :get
      post "/produtos", ProdutoController, :create
      put "/produtos/:id", ProdutoController, :update
      delete "/produtos/:id", ProdutoController, :delete
    end

    match :*, "/*path", FallbackController, :call
  end

  scope "/", WebappWeb.Controllers.Web do
    pipe_through :browser

    get "/", LoginController, :index
    post "/login", LoginController, :login
    get "/cadastro", AdminController, :register
    post "/cadastrar", AdminController, :register_create
    get "/esqueceu-senha", LoginController, :forgot_password
    post "/esqueceu-senha", LoginController, :forgot_password_email_token
    get "/redefinir-senha", LoginController, :change_password
    post "/redefinir-senha", LoginController, :change_password_confirmation

    scope "/" do
      pipe_through :authenticated

      get "/sair", LoginController, :logout

      get "/dashboard", DashController, :index

      get "/administradores", AdminController, :index
      get "/administradores/novo", AdminController, :new
      post "/administradores", AdminController, :create
      post "/administradores/:id/excluir", AdminController, :delete
      get "/administradores/:id/editar", AdminController, :edit
      post "/administradores/:id/alterar", AdminController, :update

      resources "/produtos", ProdutoController
      resources "/fornecedores", FornecedorController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebappWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:webapp, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).

    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
