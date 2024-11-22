import Config

# O runtime.exs é executado para todos os ambientes, incluindo durante os releases.
# Ele é executado após a compilação e antes do sistema iniciar.

if config_env() == :prod do
  # Verifica se a variável DATABASE_URL está definida, caso contrário, lança um erro
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

  # Configurações do repositório do Ecto
  config :webapp, Webapp.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6,
    ssl: true,
    ssl_opts: [ssl_mode: :prefer]

  # Verifica se a SECRET_KEY_BASE está definida, caso contrário, lança um erro
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  # Configurações do Endpoint
  config :webapp, WebappWeb.Endpoint,
    url: [host: host, port: port],
    http: [
      # Habilita IPv4 e IPv6
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    server: true

  # Configuração personalizada para clusters DNS, se necessário
  config :webapp, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  # Configurações adicionais, como mailer ou SSL, podem ser adicionadas aqui.
end
