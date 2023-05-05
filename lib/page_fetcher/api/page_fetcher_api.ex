defmodule PageFetcher.Api.PageFetcherApi do
  @moduledoc """
  Api wrapper for PageFetcher.
  """

  @doc """
  Gets html string from the given url.

  ## Examples

      iex> PageFetcherApi.get_html("https://google.com)
      {:ok, "<html>...</html>"}

      iex> PageFetcherApi.get_html("https://google.com)
      {:error, "Page not responding"}

      iex> PageFetcherApi.get_html("https://google.com)
      {:error, "Page not exists"}
  """
  def get_html(url) do
    case http_client().get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}}
      when status_code >= 200 and status_code <= 299 ->
        {:ok, body}

      {:ok, %HTTPoison.Response{body: body, status_code: _status_code}} ->
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp http_client do
    Application.get_env(:page_fetcher, :http_client)
  end
end
