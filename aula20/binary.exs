# Criando um binário
#         [E]  [l]  [i]  [x]  [i]  [r]  [ ] [  é   ]  [ ] [m]  [u]  [i]  [t]  [0]  [ ] [l]  [e]  [g]  [a]  [l]
binary = <<69, 108, 105, 120, 105, 114, 32, 195, 169, 32, 109, 117, 105, 116, 111, 32, 108, 101, 103, 97, 108::utf8>>

# Verificando se é um binário
IO.puts(is_binary(binary))  # true

# Manipulando binários
IO.puts(binary)  # "Elixir é muito legal"
