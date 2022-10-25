defmodule ApiProjectWeb.UserController do
  use ApiProjectWeb, :controller
  alias ApiProject.User

  # list one user with params: email & username
  def list(conn, %{"email" => email, "username" => username}) do
    user = User.get_user_with_credentials!(%{email: email, username: username})
    render(conn, "user.json", user: user)
  end

  # list one user with given userId
  def read(conn, _params, %{"userId" => id}) do
  end

  # create a user with given body
  def create(conn, _params) do
  end

  # update specific user with body
  def update(conn, _params, %{"userId" => id}) do
  end

  # delete user with given id
  def delete(conn, _params, %{"userId" => id}) do
  end
end
