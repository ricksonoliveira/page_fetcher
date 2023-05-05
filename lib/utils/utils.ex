defmodule Utils do
  @moduledoc """
  Utility layer for PageFetcher.
  """

  @doc """
  Validates if given url is valid.

  ## Examples

      iex> Utils.validate_url("http://google.com")
      {:ok, :valid}

      iex> Utils.validate_url("google.com")
      {:error, :invalid}
  """
  def validate_url(nil), do: {:error, :invalid}
  def validate_url(""), do: {:error, :invalid}

  def validate_url(url) do
    case URI.parse(url) do
      %URI{scheme: scheme, host: host}
      when not is_nil(scheme) and not is_nil(host) ->
        {:ok, :valid}

      _ ->
        {:error, :invalid}
    end
  end
end
