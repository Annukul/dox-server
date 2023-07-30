defmodule DoxServer.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias DoxServer.Schema.GithubAccount

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @cast_fields [
    :github_user_name,
    :name,
    :avatar_url,
    :profile_url,
    :github_account_id
  ]

  schema "users" do
    field :github_user_name, :string
    field :name, :string
    field :avatar_url, :string
    field :profile_url, :string

    belongs_to :github_account, GithubAccount

    timestamps()
  end

  def changeset(users, attrs) do
    users
    |> cast(attrs, @cast_fields)
    |> validate_required([
      :github_user_name,
      :name,
      :github_account_id
    ])
    |> unique_constraint([:github_user_name, :github_account_id])
  end
end
