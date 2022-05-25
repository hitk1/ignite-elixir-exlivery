defmodule Exlivery.Orders.Order do
  @attributes [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_attributes @keys

  defstruct @attributes

  def build do
    {:ok,
     %__MODULE__{
       user_cpf: nil,
       delivery_address: nil,
       items: nil,
       total_price: nil
     }}
  end
end
