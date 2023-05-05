defmodule PageFetcher.Api.PageFetcherApiTest do
  use ExUnit.Case, async: true
  import Mox

  alias PageFetcher.Api.PageFetcherApi

  @example_url "https://example.com"

  setup :verify_on_exit!

  test "get_html/1 gets html string from the given url when status code 200" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:ok,
       %HTTPoison.Response{
         body:
           "<html></head><title>Thy Title</title></head><body>Body for thy page</body></html>",
         status_code: 200
       }}
    end)

    assert {:ok, _html} = PageFetcherApi.get_html(@example_url)
  end

  test "get_html/1 returns error when status code 400" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:ok,
       %HTTPoison.Response{
         body: "Page not found",
         status_code: 404
       }}
    end)

    assert {:error, _html} = PageFetcherApi.get_html(@example_url)
  end

  test "get_html/1 returns error when invalid call" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:error,
       %HTTPoison.Error{
         reason: "Page not exists"
       }}
    end)

    assert {:error, _html} = PageFetcherApi.get_html("example.com")
  end
end
