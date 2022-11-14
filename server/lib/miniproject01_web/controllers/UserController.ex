defmodule ApiProjectWeb.UserController do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.{User, Token}
  alias ApiProjectWeb.Auth
  import Bcrypt

  def login(conn, params) do
    user = Auth.login(conn)

    if user do
      {:ok, token, claims} = Token.generate_and_sign(%{user_id: user.id})
      render(conn, "user.json", user: user, token: token)
    else
      conn
      |> put_status(401)
      |> render("error.json", reason: "Invalid credentials")
    end
  end

  # list one user with given userId
  def read(conn, %{"userId" => id}) do
    user = User.get_user(id)

    if user do
      render(conn, "user.json", user: user, token: nil)
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "User does not exist")
    end
  end

  # create a user with given body
  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "password", Bcrypt.hash_pwd_salt(user_params["password"]))

    with {:ok, %User{} = user} <- User.create_user(user_params) do
      render(conn, "user.json", user: user, token: nil)
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
      if Auth.has_right(%{
           bearer_token: user_params["token"],
           target: user,
           action: "edit_user"
         }) do
        with {:ok, %User{} = updated} <- User.update_user(user, user_params) do
          render(conn, "user.json", user: updated, token: nil)
        else
          {:error, %Ecto.Changeset{}} ->
            conn
            |> put_status(400)
            |> render("error.json", reason: "The payload does not match the expected pattern")
        end
      else
        conn
        |> put_status(401)
        |> render("error.json", reason: "You are not allowed to perform this action.")
      end
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "The requested user does not exist")
    end
  end

  def list_user_teams(conn, %{"userId" => user_id}) do
    teams = User.get_user_teams(user_id)
    render(conn, "user_teams.json", teams: teams)
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
