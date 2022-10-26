defmodule ApiProjectWeb.UserController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.User

  # list one user with params: email & username
  def list(conn, params) do
    if params["email"] && params["username"] do
      user =
        User.get_user_with_credentials(%{email: params["email"], username: params["username"]})

      if user do
        render(conn, "user.json", user: user)
      else
        conn
        |> put_status(404)
        |> render("error.json", reason: "Invalid credentials")
      end
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
      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_status(400)
        |> render("error.json", reason: "The payload does not match the expected pattern")
    end
  end

  # update specific user with body
  def update(conn, %{"userId" => id, "user" => user_params}) do
    user = User.get_user(id)

    if user do
      with {:ok, %User{} = updated} <- User.update_user(user, user_params) do
        render(conn, "user.json", user: updated)
      else
        {:error, %Ecto.Changeset{}} ->
          conn
          |> put_status(400)
          |> render("error.json", reason: "The payload does not match the expected pattern")
      end
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "The requested user does not exist")
    end
  end

  # delete user with given id
  def delete(conn, %{"userId" => id}) do
    user = User.get_user(id)

    if(user) do
      with {:ok, deleted} <- User.delete_user(user) do
        send_resp(conn, 204, "")
      else
        {:error, %Ecto.Changeset{}} ->
          conn
          |> put_status(418)
          |> render("error.json", reason: "An error has occured 🫖")
      end
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "The requested user does not exist")
    end
  end
end
