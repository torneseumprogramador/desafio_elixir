Code.require_file("UI/menu.exs", __DIR__)

defmodule ProgramaDoSergio do
  def init() do
    Menu.init()
  end
end

ProgramaDoSergio.init()
