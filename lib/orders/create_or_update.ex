defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Order, Item}

  # a clausula 'with' abaixo encadeia diversas funcoes onde todas as verificações tem que satisfazer a checagem
  # ou seja, todas as chamadas de funcoes tem que retornar {:ok, alguma_coisa} pra poder prosseguir
  # caso houve um erro em qualquer um dos estágios, o erro será retornado pra quem chamou a função
  def call(%{user_cpf: user_cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(user_cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrderAgent.save(order)
    end
  end

  # Esta função mapeia todos os parametros recebidos em 'items' e tenta buldar cada um deles
  # retornando o a struct correta ou um erro em caso de inconsistencias
  # Por fim, o resultado é passado para a ultima função que verificar se houve sucesso em executar o 'build' em todos os items recebidos
  # caso contrário, é retornado um erro e o pedido não é registrado
  defp build_items(items) do
    items
    |> Enum.map(&build_single/1)
    |> handle_build()
  end

  # Esta função executa o build de cada struct item e retorna um valor respectivo ao estado da chamada da função (sucesso ou erro)
  defp build_single(%{
         description: description,
         category: category,
         unit_price: unit_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unit_price, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  # esta função é responsável por verificar se todos os items da lista recebida por parametro (items)
  # é uma struct (isso implica que houve sucesso ao executar o build de todos os items da lista),
  # se não, um erro é retornado
  defp handle_build(items) do
    if Enum.all?(items, &is_struct/1), do: {:ok, items}, else: {:error, "Invalid items"}
  end
end
