defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Item
  # Notação para atribuição de valores default
  def create(filename \\ "report.csv") do
    order_list = build_order_list()

    File.write!(filename, order_list)
  end

  def build_order_list() do
    OrderAgent.list_all()
    |> Map.values()
    |> Enum.map(&order_string/1)
    |> IO.inspect()
  end

  def order_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    itens_string = items |> Enum.map(&item_string/1)
    "#{cpf}, #{itens_string}, #{total_price}"
  end

  def item_string(%Item{
        category: category,
        quantity: quantity,
        description: description,
        unit_price: unit_price
      }) do
    "#{category}, #{description}, #{quantity}, #{unit_price}"
  end
end
