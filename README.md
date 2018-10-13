# ExWebexteams
[![Hex.pm](https://img.shields.io/hexpm/v/ex_webexteams.svg)](https://hex.pm/packages/ex_webexteams)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_webexteams/ExWebexteams.html)
[![Build Status](https://travis-ci.org/zpeters/ex_webexteams.svg?branch=master)](https://travis-ci.org/zpeters/ex_webexteams)
[![Coverage Status](https://coveralls.io/repos/github/zpeters/ex_webexteams/badge.svg)](https://coveralls.io/github/zpeters/ex_webexteams)

This is currently a *use at your own risk* package.  The intended functionality works well in my limited test case (posting messages to a room) but has not been robustly tested.

Currently we are only exposing get, post and one "helper" type function (post_message).  Much more functionality needs to be added to make this generally useful.

## Require Configuration

TBD

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_webexteams` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_webexteams, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_webexteams](https://hexdocs.pm/ex_webexteams).

