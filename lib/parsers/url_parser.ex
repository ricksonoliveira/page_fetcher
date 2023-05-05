defmodule UrlParser do
  @moduledoc """
  Url Parser.
  """

  @doc """
  Gets assets from given html

  ## Examples

      iex> UrlParser.get_assets("<img src='https://example.com/image.jpg'>")
      ["http://example.com/image.png"]

      iex> UrlParser.get_assets("</img src=""></img>)
      []
  """
  def get_assets(""), do: {:ok, []}

  def get_assets(html) do
    {:ok,
     html
     |> Floki.find("img")
     |> Floki.attribute("src")}
  end

  @doc """
  Gets assets from given html

  ## Examples

      iex> UrlParser.get_links("<a href='https://example.com/'>Example Link</a>")
      ["https://example.com/"]

      iex> UrlParser.get_links("</a href=""></a>)
      []
  """
  def get_links(""), do: {:ok, []}

  def get_links(html) do
    {:ok,
     html
     |> Floki.find("a")
     |> Floki.attribute("href")}
  end
end
