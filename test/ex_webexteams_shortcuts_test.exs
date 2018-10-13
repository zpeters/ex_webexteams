defmodule ExWebexteamsShortcutsTest do
  use ExUnit.Case, async: true
  require ElixirMock
  import ElixirMock

  import ExWebexteams.Api.Shortcuts

  test "send plain message" do
    msg = "my message"
    expected = %{"text" => "#{msg}"}
    result = send_message(msg)
    assert expected == result
  end

  test "send markdown message" do
    msg = "my message"
    md = "*my message*"
    expected = %{"text" => "#{msg}", "markdown" => "#{md}"}
    result = send_message(msg, md)
    assert expected == result
  end

  test "send file url" do
    f = "https://my.gif/img.mygif"
    expected = %{"files" => [f]}
    result = send_file(f)
    assert expected == result
  end

  test "send file url with description" do
    f = "https://my.gif/img.mygif"
    desc = "this is my gif"
    expected = %{"files" => [f], "text" => "#{desc}"}
    result = send_file(f, desc)
    assert expected == result
  end

  test "to person email" do
    msg = Map.new()
    email = "me@here.com"
    expected = %{"toPersonEmail" => "#{email}"}
    result = to_person_email(msg, email)
    assert expected == result
  end

  test "to person id" do
    msg = Map.new()
    id = 12_345
    expected = %{"toPersonId" => id}
    result = to_person_id(msg, id)
    assert expected == result
  end

  test "to room id" do
    msg = Map.new()
    id = 12_345
    expected = %{"roomId" => id}
    result = by_room_id(msg, id)
    assert expected == result
  end

  test "send a message to a person" do
    person = "me@here.com"
    msg = "this is my message"
    expected = %{"toPersonEmail" => person, "text" => msg}

    result =
      msg
      |> send_message
      |> to_person_email(person)

    assert result == expected
  end

  test "get my last message" do
    room = 12345
    expected = %{"max" => 1, "mentionedPeople" => "me", "roomId" => room}
    result =
      find_my_messages(%{"max" => 1})
      |> by_room_id(room)
    assert result == expected
  end

  test "post message" do
    mock_api = mock_of(ExWebexteams.Api)
    person = "me@here.com"
    msg = "this is my message"

    msg
    |> send_message
    |> to_person_email(person)
    |> post_message(mock_api)

    assert_called(
      mock_api.post(
        "{\"toPersonEmail\":\"me@here.com\",\"text\":\"this is my message\"}",
        "/messages"
      )
    )
  end
end
