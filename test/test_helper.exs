# Define dynamic mocks
Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)

# Override the config settings
Application.put_env(:page_fetcher, :http_client, HTTPoison.BaseMock)

ExUnit.start()
