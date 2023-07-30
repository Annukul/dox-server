defmodule DoxServer.Repo.Migrations.AddGithubAccount do
  use Ecto.Migration

  def change do
    create table(:github_accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :access_token, :text
      add :token_expires_at, :integer

      timestamps()
    end
  end
end
