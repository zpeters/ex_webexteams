defmodule ExWebexteams.Api.Shortcuts do
  @moduledoc """
  Shortcuts to API calls
  """

  import ExWebexteams.Api

<<<<<<< HEAD
  ### Sending Messages
  def send_message(text, markdown \\ nil) do
    if markdown do
      Map.new([{"markdown", markdown}, {"text", text}])
    else
      Map.new([{"text", text}])
    end
  end

  def send_file(file, description \\ nil) do
    if description do
      Map.new([{"files", [file]}, {"text", description}])
    else
      Map.new([{"files", [file]}])
    end
  end

  def to_person_email(msg, email) do
    Map.put(msg, "toPersonEmail", email)
  end

  def to_person_id(msg, id) do
    Map.put(msg, "toPersonId", id)
  end

  def to_room_id(msg, id) do
    Map.put(msg, "roomId", id)
  end

  def post_message(msg, api \\ ExWebexteams.Api) do
    json = Poison.encode!(msg)
    json |> api.post("/messages")
=======
  ### Getting Messages
  @doc"""
  Get messages to 'me' from a roomId

  opts:
  `before` (string) - List messages before ISO8061 date
  `beforeMessage` (string) - List messages sent before messaeg ID
  `max` (integer) - maximum results
  """
  def get_room_messages(roomId, opts \\ []) do
    "/messages?roomId=#{roomId}&mentionedPeople=me"
    |> opts_handler(opts)
    |> IO.inspect
    |> get()
  end

  defp opts_handler(opts) do
    keys = Keyword.keys(opts)
    keys
    |> Enum.map(&("#{Atom.to_string(&1)}=#{Keyword.get(opts, &1)}&"))
    |> Enum.join
    |> String.slice(0..-2)
  end

  defp opts_handler(prefix, opts) do
    suffix = opts_handler(opts)
    Enum.join([prefix, suffix], "&")
  end

  ### Sending Messages
  @doc """
  Send a message to a team room

  opts:
  `markdown` - message in markdown format
  `files` - url to a single file
  """
  def send_message_to_room(message, roomId, opts \\ []) do
    json = Poison.encode!(%{
          "roomId" => roomId,
                            "text" => message,
          "markdown" => Keyword.get(opts, :markdown),
          "files" => [Keyword.get(opts, :files)]
                          })
    post("/messages", json)
  end

  @doc """
  Send a message to a person (by email)

  opts:
  `markdown` - message in markdown format
  `files` - url to a single file
  """
  def send_message_to_person_by_email(message, email, opts \\ []) do
    json = Poison.encode!(%{
          "toPersonEmail" => email,
          "text" => message,
          "markdown" => Keyword.get(opts, :markdown),
          "files" => [Keyword.get(opts, :files)]
                          })
    post("/messages", json)
  end

  @doc """
  Send a message to a person (by id)

  opts:
  `markdown` - message in markdown format
  `files` - url to a single file
  """
  def send_message_to_person_by_id(message, personId, opts \\ []) do
    json = Poison.encode!(%{
          "toPersonId" => personId,
          "text" => message,
          "markdown" => Keyword.get(opts, :markdown),
          "files" => [Keyword.get(opts, :files)]
                          })
    post("/messages", json)
>>>>>>> 6d336ad0d1af626935fd62d66e75d8c26df51142
  end

end
