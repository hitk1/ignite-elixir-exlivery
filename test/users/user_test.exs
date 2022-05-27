defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user struct" do
      response = User.build("Rua test", "Luis Paulo", "luispaulo@mail.com", "12345678900", 24)

      # Quando for usar uma factory, deve-se chamara função de construção dos dados usando a função "build"
      # passando como parametro um atom do prefixo da função da factory definida em "support" no caso "user_factory -> user"
      assert response == {:ok, build(:user)}
    end

    test "when all params are invalid, returns error" do
      response = User.build("Rua test", "Luis Paulo", "luispaulo@mail.com", "12345678900", 11)

      assert response == {:error, "Invalid parameters"}
    end
  end
end
