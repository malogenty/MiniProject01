defmodule ApiProjectWeb.Auth do
  require Logger
  use ApiProjectWeb, :controller
  alias ApiProject.{User, Token, Team}

  def get_user(token) do
    {:ok, claims} = Token.verify_and_validate(token)
    User.get_user(claims["user_id"])
  end

  def authenticate({conn, "Bearer: " <> jwt}) do
    {:ok, claims} = Token.verify_and_validate(jwt)
    User.get_user(claims["user_id"])
  end

  def authenticate({conn, "Basic: " <> token}) do
    [username, password] =
      token
      |> Base.decode64!(padding: false)
      |> String.split(":")

    with {:ok, user} <- User.authenticate_user(username, password) do
      user
    else
      {:error, error_msg} ->
        {:error, "Invalid credentials"}
    end
  end

  def has_right(%{bearer_token: token, target: target, action: action}) do
    bearer = get_user(token)

    cond do
      action == "edit_user" ->
        if bearer.id == target.id do
          true
        else
          false
        end

      action == "delete_user" ->
        if bearer.id == target.id || bearer.role == :general_manager do
          true
        else
          false
        end

      action == "view_user" ->
        cond do
          bearer.id == target.id ->
            true

          has_authority(%{bearer: bearer, target: target}) ->
            true

          true ->
            false
        end

      action == "promote_user" ->
        if bearer.role == :general_manager do
          true
        else
          false
        end
    end
  end

  def has_authority(%{bearer: bearer, target: target}) do
    cond do
      bearer.role == :employee ->
        false

      bearer.role == :manager ->
        cond do
          target.role == (:manager || :general_manager) ->
            false

          target.role == :employee ->
            same_team = Team.are_same_team(%{u1_id: bearer.id, u2_id: target.id})

            if same_team do
              true
            else
              false
            end
        end

      bearer.role == :general_manager ->
        true
    end
  end
end
