defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @attributes [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @attributes

  defstruct @attributes

  def build(
        %User{cpf: cpf, address: address},
        [%Item{} | _items] = items
      ) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total(items)
     }}
  end

  def build(_users, _items), do: {:error, "Invalid parameters"}

  defp calculate_total(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices/2)
  end

  defp sum_prices(%Item{unit_price: unit_price, quantity: quantity}, acc) do
    unit_price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
