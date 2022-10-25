defmodule ApiProjectWeb.UserController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.User

  # list one user with params: email & username
  def list(conn, %{"email" => email, "username" => username}) do
    user = User.get_user_with_credentials(%{email: email, username: username})

    if user do
      render(conn, "user.json", user: user)
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "Invalid credentials")
    end
  end

  # list one user with given userId
  def read(conn, %{"userId" => id}) do
    user = User.get_user(id)

    if user do
      render(conn, "user.json", user: user)
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "User does not exist")
    end
  end

  # create a user with given body
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- User.create_user(user_params) do
      render(conn, "user.json", user: user)
    else
      :error ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")
    end
  end

  # update specific user with body
  def update(conn, %{"userId" => id}) do
  end

  # delete user with given id
  def delete(conn, %{"userId" => id}) do
  end
end
