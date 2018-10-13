defmodule ExWebexteams.Api.Shortcuts do
  @moduledoc """
  Shortcuts to API calls
  """
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
  end
end
