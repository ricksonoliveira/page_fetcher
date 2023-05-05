defmodule PageFetcherTest do
  use ExUnit.Case, async: true
  import Mox

  @example_url "https://example.com"

  test "fetch/1 will fetch page urls correctly" do
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

    assert %{
             assets: _assets,
             links: _links
           } = PageFetcher.fetch(@example_url)
  end

  test "fetch/1 will return error when invalid" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:error,
       %HTTPoison.Error{
         reason: "Page not exists"
       }}
    end)

    assert "Page not exists" = PageFetcher.fetch("http://example.com")
  end
end
