defmodule UrlParserTest do
  use ExUnit.Case, async: true

  @mock_response_body """
    <html>
      <body>
        <img src='https://example.com/image.jpg'>
        <a href='https://example.com/'>Example Link</a>
      </body>
    </html>
  """

  describe "get_assets/1" do
    test "get_assets/1 will return a list of urls found in the <img> tags from html when ok" do
      assert {:ok, ["https://example.com/image.jpg"]} == UrlParser.get_assets(@mock_response_body)
    end

    test "get_assets/1 will return an empty list when empty html" do
      assert {:ok, []} == UrlParser.get_assets("")
    end
  end

  describe "get_links/1" do
    test "get_links/1 will return a list of urls found in the <a> tags from html when ok" do
      assert {:ok, ["https://example.com/"]} == UrlParser.get_links(@mock_response_body)
    end

    test "get_links/1 will return an empty list when empty html" do
      assert {:ok, []} == UrlParser.get_links("")
    end
  end
end
