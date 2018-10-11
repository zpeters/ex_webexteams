defmodule ExWebexteams.Api do
  @moduledoc """
  Interface to Webex Teams API through a rate limiter

  Rate limit configurable in `configs/`
  """

  ### settings
  @bucket Application.get_env(:ex_webexteams, :limit_bucket)
  @scale Application.get_env(:ex_webexteams, :limit_scale)
  @limit Application.get_env(:ex_webexteams, :limit_limit)

  @doc """
  Send a message to a team room
  """
  def send_message(message, roomId) do
    json = Poison.encode!(%{"roomId" => roomId, "text" => message})
    post("/messages", json)
  end

  ### Internal
  defp get(path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.get!(url, headers, options)
    response.body
  end

  defp post(path, body) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.post!(url, body, headers, options)
    response.body
  end

  defp ratelimit() do
    case ExRated.check_rate(@bucket, @scale, @limit) do
      {:ok, _} ->
        :ok
      {:error, _} ->
        {_, _, ms, _, _} = ExRated.inspect_bucket(@bucket, @scale, @limit)
        Process.sleep(ms)
        :ok
    end
  end

  defp generate_url(path) do
    "https://api.ciscospark.com/v1#{path}"
  end

  defp generate_headers do
    token = Application.get_env(:ex_webexteams, :webex_token)

    [
      Authorization: "Bearer #{token}",
      "Content-Type": "application/json"
    ]
  end
end
