defmodule DoxServer.GithubAccounts do
  import Ecto.Query, warn: false
  alias DoxServer.Repo

  alias DoxServer.Schema.GithubAccount

  def get_github_account!(id), do: Repo.get!(GithubAccount, id)

  def create_github_account(attrs \\ %{}) do
    %GithubAccount{}
    |> GithubAccount.changeset(attrs)
    |> Repo.insert()
  end

  def update_github_account(%GithubAccount{} = account, attrs) do
    account
    |> GithubAccount.changeset(attrs)
    |> Repo.update()
  end
end
