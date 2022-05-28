defmodule Exlivery do
  alias Exlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser
  alias Exlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Exlivery.Users.Agent, as: UserAgent

  alias Exlivery.Orders.Agent, as: OrderAgent

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  # As notações de 'delegate' são do padrão 'facade'
  # Onde somente este modulo fica como 'interface publica' e ele delega para submodulos da arquitetura
  # quais funções executar
  # No caso, é definido uma funcao 'create_or_update' que recebe alguns parametros, que por sua vez
  # executa a função 'call' dentro do modulo 'CreateOrUpdate'
  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
