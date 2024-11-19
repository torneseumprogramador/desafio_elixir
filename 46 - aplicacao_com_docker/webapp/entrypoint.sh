#!/bin/sh

echo "Esperando o banco de dados ficar disponível..."
./wait-for-it.sh db:5432 -- echo "Banco de dados disponível."

echo "Criando banco de dados (se necessário)..."
bin/webapp eval "Webapp.Release.create()"

echo "Executando migrations..."
bin/webapp eval "Webapp.Release.migrate()"

echo "Iniciando aplicação..."
bin/webapp start
