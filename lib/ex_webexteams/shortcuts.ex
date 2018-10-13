defmodule ExWebexteams.Api.Shortcuts do
  # TODO handle pagination
  # TODO add functions for rest of API endpoints (view, etc)
  @moduledoc """
  Shortcuts to API calls
  """

  import ExWebexteams.Api

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
  end

  defp opts_handler(opts) do
    keys = Keyword. keys(opts)
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
  # TODO add def spec
  # TODO add example pipelines to module doc

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

  def post_message(msg) do
    Poison.encode!(msg)
    |> post("/messages")
  end

end
