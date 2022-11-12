defmodule ApiProjectWeb.HoursWorkedController do
  use ApiProjectWeb, :controller
  require Logger
  alias ApiProject.{HoursWorked, Team, User, Repo}

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

  def get_by_day(conn, %{"user_id" => user_id, "from" => from, "to" => to}) do
    hours_worked =
      HoursWorked.get_hours_worked_from_to(%{
        user_id: user_id,
        from: Date.from_iso8601!(from),
        to: Date.from_iso8601!(to)
      })

    if hours_worked do
      render(conn, "index.json", hours_worked: hours_worked)
    end
  end

  def getAvgHoursByTeam(conn, params) do
    with {:query_params, true, date_from} <-
           {:query_params, is_binary(params["from"]), params["from"]},
         {:query_params, true, date_to} <- {:query_params, is_binary(params["to"]), params["to"]},
         {:ok, from} <- Date.from_iso8601(date_from),
         {:ok, to} = Date.from_iso8601(date_to),
         %Team{} = team <- Team.get_team!(params["team_id"]),
         avg_hours <- HoursWorked.get_avg_hours_by_team(%{team_id: team.id, from: from, to: to}) do
      render(conn, "averages.json", averages: avg_hours)
    else
      nil ->
        render(conn, "error.json", reason: "The team have not been found")

      {:query_params, _, nil} ->
        render(conn, "error.json", reason: "You must give from and to query params")

      {:query_params, false, _} ->
        render(conn, "error.json", reason: "Params must be strings")

      {:error, :invalid_format} ->
        render(conn, "error.json", reason: "Invalid date format")
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
    with {:ok, hours_worked} <- HoursWorked.get_hours_worked(id),
         {:ok, %HoursWorked{}} <- HoursWorked.delete_hours_worked(hours_worked) do
      send_resp(conn, :no_content, "")
    else
      {:hours_not_found, reason, status} ->
        conn |> put_status(status) |> render("error.json", reason: reason)
    end
  end
end
