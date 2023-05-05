defmodule PageFetcher.Services.PageFetcherService do
  @moduledoc """
  PageFetcher Service Layer
  """
  alias PageFetcher.Api.PageFetcherApi
  alias UrlParser

  @doc """
  Executes fetch in given url.

  ## Examples

      iex> PageFetcherService.execute("http://example.com")
      {:ok,
        %{
          assets: [
            "https://example.com/image.jpg"
          ],
          links: [
            "https://example.com/"
          ]
        }
      }
  """
  def execute(url) do
    with {:ok, :valid} <- Utils.validate_url(url),
         {:ok, html} <- PageFetcherApi.get_html(url),
         {:ok, assets} <- UrlParser.get_assets(html),
         {:ok, links} <- UrlParser.get_links(html) do
      {:ok,
       %{
         assets: assets,
         links: links
       }}
    else
      {:error, :invalid} ->
        {:error,
         "The given url is invalid. Please, check if it is correct and follow the default pattern such as: 'http://example.com'."}

      {:error, message} ->
        {:error, message}
    end
  end
end
