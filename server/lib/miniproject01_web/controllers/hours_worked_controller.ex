defmodule ApiProjectWeb.HoursWorkedController do
  use ApiProjectWeb, :controller

  alias ApiProject.HoursWorked

  action_fallback ApiProjectWeb.FallbackController

  def index(conn, _params) do
    hours_worked = HoursWorked.list_hours_worked()
    render(conn, "index.json", hours_worked: hours_worked)
  end

  def create(conn, hours_worked_params) do
    with {:ok, %HoursWorked{} = hours_worked} <- HoursWorked.create_hours_worked(hours_worked_params) do
      conn
      |> put_status(:created)
      |> render("show.json", hours_worked: hours_worked)
    end
  end

  def getByUser(conn, %{"user_id" => user_id}) do
    hours_worked = HoursWorked.get_hours_worked_by_user!(user_id)
    render(conn, "index.json", hours_worked: hours_worked)
  end

  def update(conn, %{"id" => id, "hours_worked" => hours_worked_params}) do
    hours_worked = HoursWorked.get_hours_worked!(id)

    with {:ok, %HoursWorked{} = hours_worked} <- HoursWorked.update_hours_worked(hours_worked, hours_worked_params) do
      render(conn, "show.json", hours_worked: hours_worked)
    end
  end

  def delete(conn, %{"id" => id}) do
    hours_worked = HoursWorked.get_hours_worked!(id)

    with {:ok, %HoursWorked{}} <- HoursWorked.delete_hours_worked(hours_worked) do
      send_resp(conn, :no_content, "")
    end
  end
end
