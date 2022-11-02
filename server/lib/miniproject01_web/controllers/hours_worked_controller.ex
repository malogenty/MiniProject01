defmodule ApiProjectWeb.HoursWorkedController do
  use ApiProjectWeb, :controller

  alias ApiProject.HoursWorked
  alias ApiProject.User
  alias ApiProject.Repo

  action_fallback(ApiProjectWeb.FallbackController)

  def index(conn, _params) do
    hours_worked = HoursWorked.list_hours_worked()

    if hours_worked != [] do
      render(conn, "index.json", hours_worked: hours_worked)
    else
      conn
      |> put_status(404)
      |> render("error.json", reason: "Hours worked not found")
    end
  end

  def create(conn, hours_worked_params) do
    with {:ok, %HoursWorked{} = hours_worked} <-
           HoursWorked.create_hours_worked(hours_worked_params) do
      conn
      |> put_status(:created)
      |> render("show.json", hours_worked: hours_worked)
    end
  end

  def getByUser(conn, %{"user_id" => user_id}) do
    with {:ok, user} <- User.get_user!(user_id),
         {:ok, hours} <- HoursWorked.get_hours_worked_by_user(user_id) do
      render(conn, "index.json", hours_worked: hours)
    else
      {:not_found, reason, status} ->
        conn |> put_status(status) |> render("error.json", reason: reason)
    end
  end

  def update(conn, %{"id" => id, "hours_worked" => hours_worked_params}) do
    with {:ok, hours} <- HoursWorked.get_hours_worked(id),
         {:ok, updated} <- HoursWorked.update_hours_worked(hours, hours_worked_params) do
      render(conn, "show.json", hours_worked: updated)
    else
      {:hours_not_found, reason, status} ->
        conn |> put_status(status) |> render("error.json", reason: reason)
    end
  end

  def delete(conn, %{"id" => id}) do
    hours_worked = HoursWorked.get_hours_worked!(id)

    with {:ok, %HoursWorked{}} <- HoursWorked.delete_hours_worked(hours_worked) do
      send_resp(conn, :no_content, "")
    end
  end
end
