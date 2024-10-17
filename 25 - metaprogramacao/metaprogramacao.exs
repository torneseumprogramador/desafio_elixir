defmodule Regras do
  defmacro regra(nome, do: bloco) do
    quote do
      def unquote(nome)(x) do
        mensagem = unquote(bloco)
        IO.puts("Mensagem: #{mensagem}\nParametro: #{x}")
      end
    end
  end
end

defmodule MeuSistema do
  require Regras

  Regras.regra(:desconto, do: "Aplicando desconto de 10%")
  Regras.regra(:bonus, do: "Adicionando bônus de 5%")
end

MeuSistema.desconto("Aluno")  # Saída: Aplicando desconto de 10%
MeuSistema.bonus("Elixir")     # Saída: Adicionando bônus de 5%
