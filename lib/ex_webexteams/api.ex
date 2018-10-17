defmodule ExWebexteams.Api do
  @moduledoc """
  Interface to Webex Teams API through a rate limiter

  ## Rate limiting
  All calls are rate limied by default through `ex_rated`.  The defaults are as follows and can be configured via configs or environment variables (*see source*). By default we allow five requests every 10 seconds.
   - `limit_bucket` = "webexteams-rate-limit"
   - `limit_scale` = 10000 - timescale in milliseconds (10000 = 10 seconds )
   - `limit_limit` = 5 - we can make 5 requests in `limit_scale` milliseconds
  """

  ### settings
  @bucket Application.get_env(:ex_webexteams, :limit_bucket, "webexteams-rate-limit")
  @scale Application.get_env(:ex_webexteams, :limit_scale, 10_000)
  @limit Application.get_env(:ex_webexteams, :limit_limit, 5)

  ### types
  @type json :: String.t()
  @type response :: %{}
  @type error :: %{}

  ### functions
  @doc "http get request"
  @spec get(String.t()) :: response | error
  def get(path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.get!(url, headers, options)
    response.body
  end

  @doc "http get request with query parameters"
  @spec get(String.t(), term) :: response | error
  def get(path, params) do
    path
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> URI.to_string()
    |> get()
  end

  @doc "http post request"
  @spec post(json, String.t()) :: response | error
  def post(body, path) do
    ratelimit()
    url = generate_url(path)
    headers = generate_headers()
    options = []
    response = HTTPoison.post!(url, body, headers, options)
    response.body
  end

  @doc "http delete request"
  @spec delete(String.t()) :: response | error
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
