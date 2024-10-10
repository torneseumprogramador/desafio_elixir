# Sigil para criar strings
sigil_string = ~s(This is a sigil string)  # Igual a "This is a sigil string"
IO.puts(sigil_string)
# Sigil para expressões regulares
sigil_regex = ~r/\d+/  # Expressão regular para dígitos

# Verificando uma correspondência de expressão regular
IO.puts("teste dsds 123 dsddssdds" =~ sigil_regex )  # true

# Sigil para listas de palavras
sigil_list = ~w(one two three)  # ["one", "two", "three"]
IO.inspect(sigil_list)
