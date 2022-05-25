defmodule Exlivery.Orders.Item do
  @categories [
    :pizza,
    :hamburguer,
    :carge,
    :prato_feito,
    :japonesa,
    :sobremesa
  ]

  @attributes [:description, :category, :unit_price, :quantity]
  @enforce_keys @attributes

  defstruct @attributes

  def build(description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unit_price: unit_price,
       quantity: quantity
     }}
  end

  def build(_desc, _category, _price, _quantity), do: {:error, "Invalid parameters"}
end
