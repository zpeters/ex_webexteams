use Mix.Config

# Defaults for rate limiting
config :ex_webexteams,
  limit_bucket: "webexteams-rate-limit",
  limit_scale: 10_000,
  limit_limit: 5

import_config "#{Mix.env()}.exs"
