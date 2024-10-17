### - Imutabilidade: Dados imutáveis não podem ser modificados após sua criação. Isso ajuda a evitar efeitos colaterais e torna o código mais previsível.
# não consigo altetar um lista no elixir sem criar outra
# não posso fazer o código abaixo
# x = [1,2,3,4]
# x[2] = 5 # ilegal pois o elixir trabalha com variáveis imutáveis

### - Funções Puras: São funções que, para os mesmos inputs, sempre retornarão o mesmo output e não têm efeitos colaterais.
defmodule Math do
  def sum(a, b) do
    a + b
  end
end

IO.puts Math.sum(2, 3)  # Resultado: 5 # função com um unico objetivo


### - Expressões sobre Instruções: Em programação funcional, você epressa o "o quê" ao invés do "como", focando em expressões que calculam valores em vez de instruções que alteram o estado do programa.

IO.puts("#### [Modo Iperativo] ####")
defmodule ExemploImperativo do
  def duplicar_lista(lista) do
    ### Mostrando como resolver
    for i <- lista do
      IO.inspect(i * 2)
    end
  end
end
ExemploImperativo.duplicar_lista([1, 2, 3])



IO.puts("#### [Modo Funcional] ####")
defmodule ExemploFuncional do
  def duplicar_lista(lista) do
    Enum.map(lista, fn x -> x * 2 end) ### O que eu quero e não como
  end
end
IO.inspect ExemploFuncional.duplicar_lista([1, 2, 3])




IO.puts("#### [Modo Funcional 'O que Resolver'] ####")
defmodule ExemploFuncional2 do
  defp multiplicar(n) do
    n * 2
  end

  def duplicar_lista(lista) do
    Enum.map(lista, fn x -> multiplicar(x) end) ### o que eu quero resolver e não como
  end
end
IO.inspect ExemploFuncional2.duplicar_lista([1, 2, 3])



# ## Imperativo (com instruções):
# defmodule SomaImperativa do
#   def somar_ate(n) do
#     total = 0  ## mostra como fazer e não o que eu quero
#     for i <- 1..n do
#       total = total + i
#     end
#     total
#   end
# end

# IO.puts SomaImperativa.somar_ate(5)  # Saída: 0



### Funcional (com expressões):
defmodule SomaFuncional do
  def somar_ate(n) do
    Enum.sum(1..n) ## O que eu quero
  end
end

IO.puts SomaFuncional.somar_ate(5)  # Saída: 15




### - Funções de Alta Ordem: São funções que podem receber outras funções como argumentos ou retorná-las como resultado. Elas são fundamentais para criar abstrações poderosas e reutilizáveis.

##### Função de alta ordem (funções que recebem funções como parametros ou retornam funções como resultado) #####
IO.puts("======[Função de alta ordem]=======")
defmodule AltaOrdemExemplo do
  def aplicar_transformacao(lista, funcao) do
    Enum.map(lista, funcao)
  end
end

# Função de transformação que duplica os valores
IO.inspect AltaOrdemExemplo.aplicar_transformacao([1, 2, 3], fn x -> x * 2 end)
# Saída: [2, 4, 6]




IO.puts("======[Retorna um função como resultado]=======")
defmodule AltaOrdemExemploRetornaFuncao do
  def somador(valor_fixo) do
    fn x -> x + valor_fixo end
  end
end

# Criando uma função que sempre soma 10
soma_10 = AltaOrdemExemploRetornaFuncao.somador(10)

# Aplicando a função retornada
IO.puts soma_10.(5)  # Saída: 15
IO.puts soma_10.(20) # Saída: 30



##### Combinando passar função e retornar função ####
IO.puts("--------------------")
defmodule AltaOrdemExemploFuncoes do
  def combinar(f1, f2) do
    fn x -> f1.(f2.(x)) end # o que fazer
  end
end

# Funções simples
multiplicar_por_2 = fn x -> x * 2 end
somar_3 = fn x -> x + 3 end

# Combinando as duas funções
nova_funcao = AltaOrdemExemploFuncoes.combinar(multiplicar_por_2, somar_3)

IO.puts nova_funcao.(5)  # Saída: 16 (primeiro soma 3 -> 8, depois multiplica por 2 -> 16)



### - Closures: Funções que podem capturar e utilizar variáveis do escopo onde foram criadas.

defmodule ClosureExemplo do
  def multiplicador(y) do
    fn x -> x * y end
  end
end

# Criando uma função que captura o valor de y = 3
multiplica_por_3 = ClosureExemplo.multiplicador(3)

# Usando a função retornada
IO.puts multiplica_por_3.(10)  # Saída: 30
IO.puts multiplica_por_3.(5)   # Saída: 15


### onde consigo altedrar o valor interno do clusure ###
defmodule ClosureExemplo2 do
  def criar_contador(contador_inicial) do
    # Captura o valor inicial do contador
    fn incremento ->
      contador_inicial = contador_inicial + incremento
      contador_inicial
    end
  end
end

# Criando um contador que começa em 0
contador = ClosureExemplo2.criar_contador(0)

# Incrementando o contador
IO.puts contador.(1)   # Saída: 1
IO.puts contador.(2)   # Saída: 3
IO.puts contador.(5)   # Saída: 8



### - Estruturas de Dados Imutáveis: Preferir o uso de estruturas de dados que não podem ser alteradas após sua criação.
lista = [1, 2, 3]
# Tentando adicionar um novo elemento
nova_lista = [4 | lista]

IO.inspect lista      # Saída: [1, 2, 3] (a lista original permanece inalterada)
IO.inspect nova_lista # Saída: [4, 1, 2, 3] (uma nova lista é criada com o elemento adicionado)


### - Pattern Matching: Uma forma de verificar e destrinchar valores de acordo com um padrão.
# Conclusão
# - Pattern Matching é uma característica poderosa de Elixir que permite verificar e destrinchar valores de forma concisa.
# - Ele pode ser usado com listas, tuplas, mapas, e até em funções e condicionais para extrair valores e definir comportamentos baseados em padrões.
# - Essa técnica torna o código mais claro e expressivo, eliminando a necessidade de verificações e loops manuais para acessar dados em estruturas complexas.

#### com case ###
defmodule Exemplo do
  def verificar_valor(valor) do
    case valor do
      1 -> "Um"
      2 -> "Dois"
      _ -> "Outro valor"
    end
  end
end

IO.puts Exemplo.verificar_valor(1)  # Saída: "Um"
IO.puts Exemplo.verificar_valor(3)  # Saída: "Outro valor"



### Pattern Matching em Funções - Destrinchando valores ####
defmodule ExemploDestrinchar do
  # Definindo função com pattern matching
  def saudar({nome, idade}) do
    "Olá #{nome}, você tem #{idade} anos!"
  end
end

IO.puts ExemploDestrinchar.saudar({"Thiago", 30})
# Saída: "Olá Thiago, você tem 30 anos!"



### - Recursão: Muitas vezes, em programação funcional, loops são expressos através de recursão. É importante entender como implementar recursão de forma eficiente, especialmente a recursão de cauda (tail recursion), que é otimizada em muitas linguagens para evitar estouro de pilha.
defmodule Fatorial do
  # Função recursiva para calcular o fatorial
  def calcular(0), do: 1
  def calcular(n) when n > 0 do
    n * calcular(n - 1)
  end
end

IO.puts Fatorial.calcular(5)  # Saída: 120



### - Map, Filter, e Reduce: São operações fundamentais para trabalhar com coleções de dados de maneira declarativa.

# Multiplicando cada elemento da lista por 2
lista = [1, 2, 3, 4, 5]
nova_lista = Enum.map(lista, fn x -> x * 2 end)

IO.inspect nova_lista  # Saída: [2, 4, 6, 8, 10]



# Filtrando os números pares de uma lista
lista = [1, 2, 3, 4, 5, 6]
pares = Enum.filter(lista, fn x -> rem(x, 2) == 0 end)

IO.inspect pares  # Saída: [2, 4, 6]



# Somando todos os elementos de uma lista
lista = [1, 2, 3, 4, 5]
soma = Enum.reduce(lista, 0, fn x, acc -> x + acc end)

IO.puts soma  # Saída: 15



#### - Composição de Funções: A capacidade de combinar duas ou mais funções para criar uma nova função.
defmodule ComposicaoExemplo do
  # Função que multiplica por 2
  def multiplica_por_2(n) do # função pura
    n * 2
  end

  # Função que soma 3
  def soma_3(n) do # função pura
    n + 3
  end

  # Composição das funções
  def compor(n) do
    n
    |> multiplica_por_2()
    |> soma_3()
  end
end

# Testando a composição de funções
IO.puts ComposicaoExemplo.compor(4)  # Saída: 11 (4 * 2 + 3)


#### outro exemplo de composição #####
multiplica_por_2 = fn x -> x * 2 end
soma_3 = fn x -> x + 3 end
composicao = fn x -> x |> multiplica_por_2.() |> soma_3.() end
IO.puts composicao.(4)  # Saída: 11
