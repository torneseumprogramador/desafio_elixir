lista = [1, 2, 3]
[maca | resto] = lista
IO.inspect(maca)   # Output: 1 (valor removido)
IO.inspect(resto)  # Output: [2, 3] (nova lista sem o primeiro valor)
