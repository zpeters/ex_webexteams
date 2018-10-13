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
  # TODO create a spec for this
  def get(path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.get!(url, headers, options)
    response.body
  end

  @doc """
  Get a resource with parameterized filters (see webex api documentation)

  Example `get("/rooms", %{"teamId" => 1})`
  """
  def get(path, params) do
    path
      |> URI.parse()
      |> Map.put(:query, URI.encode_query(params))
      |> URI.to_string()
      |> get()
  end

  @doc """
  Post a resource (see webex api documentation)

  Example `post("/messages", json")`
  """
  # TODO create a spec for this
  def post(body, path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.post!(url, body, headers, options)
    response.body
  end

  @doc """
  Delete a resource (see webex api documentation)

  Example `delete("/messages/1")`
  """
  def delete(path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.delete!(url, headers, options)
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
