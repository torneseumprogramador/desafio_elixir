# Fogetes

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fogetes` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fogetes, "~> 0.1.0"}
  ]
end
```

### Instalar dependencias do projeto
```shell
mix deps.get
```

### Build
```shell
mix compile
```

### Executar o projeto
```shell
iex -S mix 
# entro no console e rodo os métodos de forma manual
# > Foguetes.init()
```

### Rodar o projeto
```shell
mix run
mix run -- "primeiro_parametro" "segundo_parametro" # passando parametros
ENV=dev mix run # passando por variável de ambiente
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/fogetes>.

# Exercicio

Sergião dos foguetes é um cientista que precisa avaliar sua turma
para isso ele precisa de um sistema que armazene:
- id (automatico)
- nome
- matricula
- notas (lista, pode colocar quantas quiser)

Este sistema precisa ter um menu onde:
1 - Cadastrar aluno
2 - Listar alunos
3 - Alterar aluno
4 - Procurar aluno
5 - Excluir aluno
0 - Sair do programa

Na lista de alunos, sempre mostrar suas notas e a média aritimética
ID: 12343213
Nome: Elena
Matricula: MSE143
Notas: [3, 5, 9]
Média: (3+5+9)/ 3 = 5,66
