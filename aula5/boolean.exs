nome1 = IO.gets("Digite um nome\n") |> String.trim()
nome2 = IO.gets("Digite outro nome\n") |> String.trim()

comparativo = nome1 == nome2

IO.puts("O valor comparativo é de: #{comparativo}")
