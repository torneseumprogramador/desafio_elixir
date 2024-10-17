#### Struct é um map tunado, podemos ter mais funções e propriedades pré definidas ###

### exemplo simples ###
defmodule User do
  defstruct name: "John Doe", age: 30, active: true
end

## sempre preciso colocar dentro de um contexto de módulo para utilizar o struct
defmodule Main do
  def run do
    # criando uma instancia
    user = %User{}
    IO.inspect(user)

    user2 = %User{name: "Marcos"} # uma estrutura alterando valor padrão
    IO.inspect(user2)

    # É ilegal e trtorna erro, não posso criar novas
    # propriedades que não foram pré definidas
    #user3 = %User{nova_propriedade: "Teste"}

    ### para acessar propriedades, acessamos com .
    IO.puts("Nome: #{user.name}")
    IO.puts("Idade: #{user.age}")
    IO.puts("Ativo: #{user.active}")

    ## atualizar struct ###
    # Ilegal ... as propriedades de uma struct e a struct é imutável no elixir
    # user.nome = "John Aran"

    ## para alterar precisa criar uma nova struct, forma para alterar mais de uma propriedade
    user = %User{name: "John Aran", age: user.age, active: user.active}
    IO.inspect(user)

    ## outra forma mais elegante de alterar e unitária
    updated_user = %{user | age: 26}
    IO.inspect(updated_user)


    IO.puts("===== testa se o struct é de um tipo ======")
    ### valida se é uma struct ###
    IO.puts(is_struct(%User{})) # true

    user1 = %User{}

    IO.puts(is_struct(user1, User)) # true
    IO.puts("===== testa se o struct é de um tipo ======")
  end
end

Main.run()


## Definindo sem valores padrão ###
defmodule Product do
  defstruct [:name, :price]
end

defmodule Main2 do
  def run do
    # Criando uma instância sem valores padrão
    product = %Product{name: "Book", price: 10.0}
    IO.inspect(product)


    product_vazio = %Product{}
    IO.inspect(product_vazio)
  end
end

Main2.run()



####  Usando Structs com Funções ####
defmodule UserFn do
  defstruct name: "John Doe", age: 30

  def print_user(%UserFn{name: name, age: age}) do
    IO.puts("Name: #{name}, Age: #{age}")
  end

  ### habilitar caso vc queria função que receba também uma struct User ###
  ## exemplo de overloadind (Posso criar métodos com mesmo nome, porém com propriedades diferentes)
  # def print_user(%User{name: name, age: age}) do
  #   IO.puts("Name: #{name}, Age: #{age}")
  # end
end

defmodule MainFn do
  def run do
    user = %UserFn{name: "Bob", age: 40}
    UserFn.print_user(user)
    # Output: "Name: Bob, Age: 40"

    # # Isso causaria um erro
    # user = Map.put(%User{}, :new_field, "value")
    # IO.inspect(user)


    # Ilegal, não posso passar tipos diferentes do que foi definido na função
    # user = %User{name: "Bob", age: 40}
    # UserFn.print_user(user) # passando um objeto de tipagem diferente de UserFn


    ### repedi aqui pois já tenho o User e o UserFn definido
    IO.puts("===== testa se o struct é de um tipo ======")
    ### valida se é uma struct ###
    IO.puts(is_struct(%User{})) # true

    user1 = %User{}
    userfn1 = %UserFn{}

    IO.puts(is_struct(user1, User)) # true
    IO.puts(is_struct(userfn1, User)) # false
    IO.puts("===== testa se o struct é de um tipo ======")
  end
end

MainFn.run()



defmodule Dog do
  defstruct species: "dog", sound: "woof"
end

defmodule Cat do
  defstruct species: "cat", sound: "meow"
end

defmodule Animal do
  def make_sound(%{sound: sound}) do # uma espécie de spreading para propriedade sound, extraindo do objeto e tendo a variável disponível para uso no método
    IO.puts(sound)
  end
end

defmodule MainAnimal do
  def run do
    dog = %Dog{}
    cat = %Cat{}
    Animal.make_sound(dog) # Output: "woof"
    Animal.make_sound(cat) # Output: "meow"
  end
end

MainAnimal.run()




#### exemplo de overload com pattern matching ###
defmodule OverloadPatternMatching do
  def print_user(%User{name: "Alice"} = user) do
    IO.puts("Bem dia #{user.name}, vocês está com #{user.age} anos de idade")
  end

  def print_user(%User{name: "Leandro"} = user) do
    IO.puts("Boa tarde #{user.name}, vocês está com #{user.age} anos de idade")
  end
end


defmodule MainPatternMatching do
 def run do
   ### Pattern Matching para validação de valores da estrutura ###

    # estaria no padrão
    IO.puts("=================")
    x = %User{name: "Alice"} = %User{name: "Alice", age: 25}
    IO.inspect(x)

    # estaria fora do padrão por isso dá erro ILEGAL
    # x = %User{name: "Alice"} = %User{name: "Bruno", age: 25}
    # IO.inspect(x)
    # IO.puts("=================")
    # Output: Match bem-sucedido


    # OverloadPatternMatching.print_user(%User{}) ## Ilegal
    OverloadPatternMatching.print_user(%User{name: "Alice"}) ## legal
    OverloadPatternMatching.print_user(%User{name: "Leandro"}) ## legal
 end
end


MainPatternMatching.run()


#### polimorfismo utilizando defprotocol e defimpl #####

# Definindo o protocolo
defprotocol Describable do ## Parecido com uma interface no c#
  @doc "Descreve o objeto"
  def describe(entity)
end

# Definindo a struct Dog
defmodule Dog1 do
  defstruct name: "Unknown", breed: "Unknown"
end

# Implementando o protocolo para Dog
defimpl Describable, for: Dog1 do
  def describe(%Dog1{name: name, breed: breed}) do
    "Dog's name is #{name}, breed is #{breed}"
  end
end

# Definindo a struct Cat
defmodule Cat1 do
  defstruct name: "Unknown", color: "Unknown"
end

# Implementando o protocolo para Cat
defimpl Describable, for: Cat1 do
  def describe(%Cat1{name: name, color: color}) do
    "Cat's name is #{name}, color is #{color}"
  end
end

defmodule MainPolimorfismo do
  def run do
    dog = %Dog1{name: "Buddy", breed: "Labrador"}
    cat = %Cat1{name: "Whiskers", color: "Black"}

    IO.puts Describable.describe(dog)  # Output: "Dog's name is Buddy, breed is Labrador"
    IO.puts Describable.describe(cat)  # Output: "Cat's name is Whiskers, color is Black"
  end
end

MainPolimorfismo.run()
