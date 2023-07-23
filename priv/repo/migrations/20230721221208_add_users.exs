defmodule DoxServer.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :github_user_name, :string
      add :name, :string
      add :avatar_url, :string
      add :profile_url, :string
      add :github_account_id, references(:github_accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
  end
end
