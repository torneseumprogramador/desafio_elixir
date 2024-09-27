#### Criando um map com chave-valor
map = %{"nome" => "Danilo", "idade" => 29}
IO.inspect(map)
#### Acessando diretamente
nome = map["nome"]
IO.inspect(nome)  # "Danilo"

#### Criando um map com átomos como chaves
map = %{nome: "Danilo", idade: 29}
IO.inspect(map)
#### Acessando diretamente
nome = map[:nome]
IO.inspect(nome)  # "Danilo"
#### Acessando diretamente atom por map.key, se não existir a chave da erro
nome = map.nome
IO.inspect(nome)  # "Danilo"

#### Criando um map com integer como chaves
map = %{1 => "Danilo", 2 => 29}
IO.inspect(map)

#### Acessando diretamente
nome = map[1]
IO.inspect(nome)  # "Danilo"

#### Criando um map usando Map.new
map = Map.new([{:nome, "Danilo"}, {:idade, 29}]) # passando uma lista de tupla
IO.inspect(map)

#### Acessando diretamente
nome = map[:nome]
IO.inspect(nome)  # "Danilo"

#### Acessando diretamente
idade = Map.get(map, :idade)
IO.inspect(idade)  # 29

#### Tentando acessar uma chave inexistente
profissao = Map.get(map, :profissao)
IO.inspect(profissao)  # nil

#### Tentando acessar uma chave inexistente
profissao = map[:profissao]
IO.inspect(profissao)  # nil

#### retona "Desconhecido" caso não tenha a chave
profissao = Map.get(map, :profissao, "Desconhecido")
IO.inspect(profissao)  # "Desconhecido"


#### altera o conteúdo de um map
# map[:idade] = 30 # ilegal, não podemos utilizar assim, pois o map é imutável
# IO.inspect(map)

#### altera o conteúdo de um map
map_atualizado = Map.put(map, :idade, 30)
IO.inspect(map_atualizado)


#### excluindo uma key do map
# Definindo o map original
map = %{nome: "João", idade: 25, cidade: "São Paulo"}
# Exibindo o map
IO.inspect(map)

# Removendo a chave :cidade
map = Map.delete(map, :cidade)

# Exibindo o map atualizado
IO.inspect(map)


#### listanto keys de um map
# Definindo o map
map = %{nome: "João", idade: 25, cidade: "São Paulo"}

# Obtendo todas as chaves do map
keys = Map.keys(map)

# Exibindo as chaves
IO.inspect(keys)

Enum.each(keys, fn key ->
  IO.puts("Key: #{ key }")
  IO.puts("valor: #{ map[key] }")
end)


#### Verifica se uma key existe
# Definindo o map
map = %{nome: "João", idade: 25, cidade: "São Paulo"}

# Verificando se a chave :idade existe
existe_idade = Map.has_key?(map, :idade)

# Verificando se a chave :endereco existe
existe_endereco = Map.has_key?(map, :endereco)

# Exibindo os resultados
IO.inspect(existe_idade)   # true
IO.inspect(existe_endereco) # false
