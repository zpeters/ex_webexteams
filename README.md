# ExWebexteams
[![Hex.pm](https://img.shields.io/hexpm/v/ex_webexteams.svg)](https://hex.pm/packages/ex_webexteams)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_webexteams/ExWebexteams.html)
[![Build Status](https://travis-ci.org/zpeters/ex_webexteams.svg?branch=master)](https://travis-ci.org/zpeters/ex_webexteams)
[![Coverage Status](https://coveralls.io/repos/github/zpeters/ex_webexteams/badge.svg)](https://coveralls.io/github/zpeters/ex_webexteams)

This is currently a *use at your own risk* package.  The intended functionality works well in my limited test case (posting messages to a room) but has not been robustly tested.

## Required Configuration
The following configuration information is required to connect to the Teams API.  This can be supplied through creating a `dev.secret.exs` and `prod.secret.exs` file or by setting environment variables (preferred for production).

### Obtaining required configuration
1. Webex Token: See [Creating a Webex Teams Bot](https://developer.webex.com/bots.html)

## Optional configuration
The rate limiter [ex_rated](https://hex.pm/packages/ex_rated) can be configured using *secret files* or *environment variables*.  See `ExWebexteams.Api` for details

## Using secret files
`dev.secret.exs` and `prod.secret.exs` are in the `config` folder and are called based on the environment you are in.  Below is an example file
```
use Mix.Config

config :ex_webexteams,
  webex_token: "MYTOKEN"
```
## Using environment variables
The following environment variables need to be set if you are not using a *secret* file. This is the recommended method for production.
-  `WEBEX_TOKEN`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_webexteams` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_webexteams, "~> 0.1.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_webexteams](https://hexdocs.pm/ex_webexteams).

