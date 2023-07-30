defmodule DoxServerWeb.Api.V1.AuthController do
  use DoxServerWeb, :controller

  alias DoxServer.Oauth.Github
  alias DoxServer.GithubAccounts
  alias DoxServer.Users
  alias DoxServer.Repo

  def authorize(conn, params) do
    token = Github.get_access_token_from_code(params["code"])

    user =
      case token do
        {:ok, access_token} ->
          {:ok, account} = GithubAccounts.create_github_account(%{access_token: access_token})

          {:ok, usr} = Users.get_create_github_user(access_token, account.id)

          Repo.preload(usr, :github_account)

        _ ->
          {:error}
      end

    conn
    |> put_status(:ok)
    |> render("user.json", %{user: user})
  end
end
