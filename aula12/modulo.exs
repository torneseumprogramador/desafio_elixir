### Modulo é um recurso no elixir para agrupar funções
### Em um módulo é posivel criar variáveis, porém não são expostas, fora do modulo, exemplo abaixo

defmodule MyConfig do
  # Definindo um atributo de módulo
  @mensagem "Olá, mundo!" # variáveis com @ são tratados como constantes dentro do modulo
  @numero_pi 3.14159

  # Função que usa o atributo de módulo
  def get_mensagem do
    IO.puts(@mensagem)
  end

  # função ilegal, pois não se pode alterar uma variável com @
  def set_mensagem(valor) do
    @mensagem = valor # ilegal
  end

  def calcula_area(radius) do
    # Usando @numero_pi como constante
    @numero_pi * radius * radius
  end
end

# Chamando as funções
# MyConfig.set_mensagem("Aula Elixir") # erro
# MyConfig.get_mensagem()            # Saída: "Olá, mundo!"
IO.puts MyConfig.calcula_area(3)      # Saída: 28.27431
# IO.puts MyConfig.@mensagem # não é possivel acessar variáveis internas do modulos


###### como gerar documentação de um modulo para visualizar ao passar o mouse na função
defmodule MyMath do
  @moduledoc """
  Módulo com funções matemáticas básicas.
  """

  @doc """
  Soma dois números.

  ## Exemplos

      iex> MyMath.add(2, 3)
      5

  """
  def add(a, b) do
    a + b
  end

  @doc """
  Subtrai o segundo número do primeiro.

  ## Exemplos

      iex> MyMath.subtract(5, 3)
      2

      iex> MyMath.subtract(5, 1)
      4

  """
  def subtract(a, b) do
    a - b
  end
end

MyMath.add(1, 2)
MyMath.subtract(1, 2)
