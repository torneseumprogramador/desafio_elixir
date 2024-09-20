# Erro pois não existe uma conversão direta nativa que faça string virar boolean

{ bol, _ } = IO.gets("Digite true ou false\n") |> String.trim() |> Boolean.parse()

IO.puts("O valor capturado é: #{bol}")
