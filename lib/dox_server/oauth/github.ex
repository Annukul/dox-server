defmodule DoxServer.Oauth.Github do
  def get_access_token_from_code(code) do
    url = github_token_url(code)

    response = HTTPoison.post(url, [], [{"Content-Type", "application/json"}])

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, extract_access_token(body)}

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:error, body}
    end
  end

  def get_github_user(access_token) do
    url = get_github_user_url()

    response = HTTPoison.get(url, [{"Authorization", "Bearer #{access_token}"}])

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:error, body}
    end
  end

  def extract_access_token(input) do
    case Enum.find_value(String.split(input, "&"), &extract_token/1) do
      {:ok, token} -> token
      _ -> nil
    end
  end

  defp extract_token(param) do
    case String.split(param, "=") do
      ["access_token", token] -> {:ok, token}
      _ -> :error
    end
  end

  defp github_token_url(code) do
    client_id = "ae428d1eef36e06da413"
    client_secret = "0b06ed3596ce4a2dc576bd51c03dc83c725ba2e2"
    redirect_uri = "https://dox01.vercel.app/oauth/github/callback"

    "https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}&redirect_uri=#{redirect_uri}"
  end

  defp get_github_user_url() do
    "https://api.github.com/user"
  end
end
