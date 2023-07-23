defmodule DoxServerWeb.Api.V1.AuthController do
  use DoxServerWeb, :controller

  alias DoxServer.Oauth.Github
  alias DoxServer.GithubAccounts
  alias DoxServer.Users

  def authorize(conn, params) do
    token = Github.get_access_token_from_code(params["code"])

    case token do
      {:ok, access_token} ->
        {:ok, account} = GithubAccounts.create_github_account(%{access_token: access_token})

        Users.get_create_github_user(access_token, account.id)
      _ ->
        {:error}
    end

    conn
    |> put_status(:ok)
    |> json(%{message: "OK"})
  end
end
