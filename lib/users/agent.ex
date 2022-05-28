defmodule Exlivery.Users.Agent do
  alias Exlivery.Users.User

  # Agents são processos específicos do elixir que são usados para manter estados
  use Agent

  # Sempre é obrigatório inicializar o agente (processo), para que as operações possam acontecer
  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  # O metodo update de 'Agent' é usado para atualizar ou inserir um valor dentro do estado do Agent
  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  # O metodo get de 'Agent' é usado para recuperar um dado de dentro do estado.
  # No caso, estamos usando a função 'get_user' para recuperar um usuario de dentro do estado do agent, a partir do CPF
  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{cpf: cpf} = user) do
    Map.put(state, cpf, user)
  end
end
