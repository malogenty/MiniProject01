defmodule ApiProjectWeb.UsersController do
  use ApiProjectWeb, :controller

  alias ApiProject.MiniProject01
  alias ApiProject.MiniProject01.Users

  action_fallback ApiProjectWeb.FallbackController

  def index(conn, _params) do
    user = MiniProject01.list_user()
    render(conn, "index.json", user: user)
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- MiniProject01.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = MiniProject01.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = MiniProject01.get_users!(id)

    with {:ok, %Users{} = users} <- MiniProject01.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = MiniProject01.get_users!(id)

    with {:ok, %Users{}} <- MiniProject01.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
