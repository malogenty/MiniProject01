defmodule ApiProjectWeb.UserController do
  use ApiProjectWeb, :controller
  alias ApiProject.User

  # list one user with params: email & username
  def list(conn, _params) do
    user = User.get_user(1)
    json(conn, %{user: user})
  end

  # list one user with given userId
  def read(conn, _params, %{userId => id}) do

  end

  # create a user with given body
  def create(conn, _params) do

  end

  # update specific user with body
  def update (conn, _params, %{userId => id}) do

  end

  # delete user with given id
  def delete (conn, _params, %{userId => id}) do

  end

end
