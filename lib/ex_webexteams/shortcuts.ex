defmodule ExWebexteams.Api.Shortcuts do
  @moduledoc """
  Shortcuts is a set of "shortcuts" to common api call.  They are designed to be useable in a pipeline (described below)

  ## Pipelines
  ### Example sending messages
  *Send a text message to a room*
  ```
  @room = 12345
  send_message("my message") |> by_room_id(@room) |> post_message
  ```

  *Send a file to a user*
  ```
  @user = "person@here.com"
  @file = "https://files.com/funny.gif"
  send_file(@file) |> to_person_email(@user) |> post_message
  ```

  ## Example getting messages
  *Get the last message for me from a room*
  ```
  @room = 12345
  find_my_messages([:max, 1]) |> by_room_id(@room) |> get_messages
  ```
  """
  @typep message :: %{String.t() => String.t()}
  @typep options :: %{String.t() => String.t()}

  @doc "Send a text message with optional markdown"
  @spec send_message(String.t(), String.t()) :: message
  def send_message(text, markdown \\ nil) do
    if markdown do
      Map.new([{"markdown", markdown}, {"text", text}])
    else
      Map.new([{"text", text}])
    end
  end

  @doc "Send a file (by url) with an optional description"
  @spec send_file(String.t(), String.t()) :: message
  def send_file(file, description \\ nil) do
    if description do
      Map.new([{"files", [file]}, {"text", description}])
    else
      Map.new([{"files", [file]}])
    end
  end

  @doc "Send a prepared message to a person by email"
  @spec to_person_email(message, String.t()) :: message
  def to_person_email(msg, email) do
    Map.put(msg, "toPersonEmail", email)
  end

  @doc "Send a prepared message to a person by id"
  @spec to_person_id(message, String.t()) :: message
  def to_person_id(msg, id) do
    Map.put(msg, "toPersonId", id)
  end

  @doc "Get or Send a prepared message to a room by id"
  @spec by_room_id(message, String.t()) :: message
  def by_room_id(msg, id) do
    Map.put(msg, "roomId", id)
  end

  @doc "Post a prepared message to webex"
  @spec post_message(message, function()) :: {:ok, any}
  def post_message(msg, api \\ ExWebexteams.Api) do
    json = Poison.encode!(msg)
    json |> api.post("/messages")
  end

  @doc """
  Find messages from a room

  ## Options example

  Before message "1234"
  ```
  find_my_messages(%{"beforeMessage" => 1234})
  ```

  Max of 10 messages before a time (ISO8601 `yyyy-MM-dd'T'HH:mm:ss.SSSZ`)
  ```
  find_my_messages(%{"max" => 10, "before" => "2018-09-01T01:23:00.000Z"})
  ```

  """
  @spec find_my_messages(options) :: options
  def find_my_messages(options \\ %{}) do
    Map.new([{"mentionedPeople", "me"}])
    |> Map.merge(options) 
  end

  @doc "Get a messages from webex"
  @spec get_messages(options, function()) :: {:ok, any}
  def get_messages(options, api \\ ExWebexteams.Api) do
     api.get("/messages", options)
  end
end
