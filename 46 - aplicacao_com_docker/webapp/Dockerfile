# Etapa 1: Build
FROM elixir:1.16.1-alpine AS builder

# Instalar dependências do sistema
RUN apk add --no-cache build-base git

# Instalar Hex e Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Configurações do app
WORKDIR /app

# Configurar o ambiente como produção
ENV MIX_ENV=prod

# Copiar arquivos mix.exs e mix.lock
COPY mix.exs mix.lock ./

# Instalar dependências de produção
RUN mix deps.get --only prod && \
    mix deps.compile

# Copiar código da aplicação
COPY . .

# Compilar o projeto
RUN mix compile

# Gerar os assets
RUN mix phx.digest

# Construir o release
RUN mix release

# Etapa 2: Runtime
FROM alpine:3.17 AS runtime

# Instalar dependências do sistema
RUN apk add --no-cache libstdc++ ncurses openssl

# Configurações do app
ENV MIX_ENV=prod \
    LANG=C.UTF-8 \
    PORT=4000 \
    REPLACE_OS_VARS=true

WORKDIR /app

# Copiar release da etapa anterior
COPY --from=builder /app/_build/prod/rel/* /app/
COPY public /app/public

# Adicione o script wait-for-it.sh
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expor a porta
EXPOSE 4000

# Iniciar a aplicação
CMD ["/app/entrypoint.sh"]
