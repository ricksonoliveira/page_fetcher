defmodule PageFetcher do
  @moduledoc """
  PageFetcher main conntext.
  """
  alias PageFetcher.Services.PageFetcherService

  @doc """
  Fetches urls from pages given an url.

  ## Examples

      iex> PageFetcher.execute(url)
        %{
          assets: [
            "https://example/image-01",
            "https://example/image-02"
          ],
          links: [
            "https://example/link-01",
            "https://example/link-02"
          ]
        }

  """
  def fetch(url) do
    case PageFetcherService.execute(url) do
      {:ok, resource} ->
        resource

      {:error, message} ->
        message
    end
  end
end
