import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tix_clock, TixClockWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4L8PaUR5XDALedvlABwNpxYnjS0Zvgy6u65t5A1WIw43p2ed/mkx/drpm6ejwGQF",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
