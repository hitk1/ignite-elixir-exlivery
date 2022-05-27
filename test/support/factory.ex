defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  # Definição de dados usados para testes, devem seguir esse padrão de definição de nome
  # Ou seja, o nome da struct ou entidade seguido de um underline e factory "_factory"
  def user_factory do
    %User{
      address: "Rua test",
      name: "Luis Paulo",
      email: "luispaulo@mail.com",
      cpf: "12345678900",
      age: 24
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de peperoni",
      category: :pizza,
      quantity: 1,
      unit_price: Decimal.new("35.5")
    }
  end
end
