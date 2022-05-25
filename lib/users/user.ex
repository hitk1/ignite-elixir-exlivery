defmodule Exlivery.Users.User do
  @attributes [:name, :email, :cpf, :age]
  # a diretiva "enforce keys", diz que a estrutura passada como parametro, tem atributos obrigatórios
  # por sua vez, quando definida na 'struct', a mesma não poderá ser inicializada com os respectivos valores em nil
  @enforce_keys @attributes

  defstruct @attributes

  # é comum ter uma função para buildar a estrutura, para faciltar
  # No caso só sera possivel criar a struct se age for maior ou igual a 18
  def build(name, email, cpf, age) when age >= 18 do
    {:ok,
     %__MODULE__{
       name: name,
       email: email,
       cpf: cpf,
       age: age
     }}
  end

  def build(_name, _email, _cpf, _age), do: {:error, "Invalid parameters"}
end
