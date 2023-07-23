defmodule DoxServer.Users do
  import Ecto.Query, warn: false
  alias DoxServer.Repo

  alias DoxServer.Schema.User
  alias DoxServer.Oauth.Github

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def get_create_github_user(access_token, github_account_id) do
    {:ok, user} = Github.get_github_user(access_token)

    attrs = %{
      github_user_name: user["login"],
      name: user["name"],
      avatar_url: user["avatar_url"],
      profile_url: user["profile_url"],
      github_account_id: github_account_id
    }

    create_user(attrs)
  end
end
