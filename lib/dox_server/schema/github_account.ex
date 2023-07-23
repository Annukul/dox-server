defmodule DoxServer.Schema.GithubAccount do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @cast_fields [
    :access_token,
    :token_expires_at
  ]

  schema "github_accounts" do
    field :access_token, :string
    field :token_expires_at, :integer, default: 31_536_000

    timestamps()
  end

  def changeset(github_accounts, attrs) do
    github_accounts
    |> cast(attrs, @cast_fields)
    |> validate_required([
      :access_token
    ])
    |> unique_constraint(:access_token)
  end
end
