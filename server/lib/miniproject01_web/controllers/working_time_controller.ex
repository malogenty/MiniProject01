defmodule ApiProjectWeb.WorkingTimeController do
  use ApiProjectWeb, :controller

  alias ApiProject.WorkingTime

  action_fallback ApiProjectWeb.FallbackController

  def readAll(conn, %{"userId" => userId, "end" => end_datetime, "start" => start_datetime}) do
    working_times = WorkingTime.get_working_time_by_user(%{user_id: userId, start: start_datetime, end: end_datetime})
    render(conn, "index.json", working_times: working_times)
  end

  def readOne(conn, %{"id" => id, "userId" => userId}) do
    working_time = WorkingTime.get_working_time!(%{id: id, user_id: userId})
    render(conn, "show.json", working_time: working_time)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- WorkingTime.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTime.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- WorkingTime.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTime.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTime.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
