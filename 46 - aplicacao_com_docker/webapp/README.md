# Webapp
### Acessar aplicação
`mix phx.server`

- [`localhost:4000`](http://localhost:4000) Acessar do seu navegador.

### Entrar no console
`iex -S mix phx.server`

# Doc API
https://editor.swagger.io/

### colocar o conteúdo do e colocar no editor
http://localhost:4000/public/swagger.json


### Docker comandos ###
```shell
# fazer o build da imagem
docker build -t webapp . 
# rodar o container
docker run --name webapp_container -p 4000:4000 \
  -e DATABASE_URL="ecto://USER:PASS@HOST/DATABASE" \
  -e SECRET_KEY_BASE="uma-chave-secreta-grande-e-randômica" \
  -e PORT=4000 \
  webapp
```

### Docker-compose comandos ###
```shell
docker-compose up --build

# incluindo usuario:
# email: danilo@teste.com
# senha: 123456
./inserir_usuario_container.sh
```



