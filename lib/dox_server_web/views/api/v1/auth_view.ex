defmodule DoxServerWeb.Api.V1.AuthView do
  use DoxServerWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      github_user_name: user.github_user_name,
      avatar_url: user.avatar_url
    }
  end
end
