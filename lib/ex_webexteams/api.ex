defmodule ExWebexteams.Api do
  @moduledoc """
  Interface to Webex Teams API through a rate limiter
  """

  ### settings
  @bucket Application.get_env(:ex_webexteams, :limit_bucket, "webexteams-rate-limit")
  @scale Application.get_env(:ex_webexteams, :limit_scale, 10_000)
  @limit Application.get_env(:ex_webexteams, :limit_limit, 5)

  @doc """
  Get a resource (see webex api documentation)

  Example `get("/rooms")`
  """
  def get(path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.get!(url, headers, options)
    response.body
  end

  @doc """
  Post a resource (see webex api documentation)

  Example `post("/messages", json")`
  """
  def post(path, body) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.post!(url, body, headers, options)
    response.body
  end

  ### Internal
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
