use Mix.Config

# if secret exists use that, otherwise 
# use env variables
if File.exists?("config/dev.secret.exs") do
  import_config "dev.secret.exs"
else
  config :ex_webexteams,
    webex_token: System.get_env("WEBEX_TOKEN")
end
