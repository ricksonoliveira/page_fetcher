defmodule PageFetcher.Services.PageFetcherServiceTest do
  use ExUnit.Case, async: true

  import Mox

  alias PageFetcher.Services.PageFetcherService
  @example_url "https://example.com"

  @mock_response_body """
    <html>
      <body>
        <img src='https://example.com/image.jpg'>
        <a href='https://example.com/'>Example Link</a>
      </body>
    </html>
  """

  @mock_empty_response_body """
    <html>
      <body>
        Some body
      </body>
    </html>
  """

  test "execute/1 will execute corretcly when given a url" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:ok,
       %HTTPoison.Response{
         body: @mock_response_body,
         status_code: 200
       }}
    end)

    assert {:ok, resource} = PageFetcherService.execute(@example_url)

    refute is_nil(resource.assets)
    refute is_nil(resource.links)
    assert resource.assets == ["https://example.com/image.jpg"]
    assert resource.links == ["https://example.com/"]
  end

  test "execute/1 will return empty resources when no tag <img> or <a> in url" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:ok,
       %HTTPoison.Response{
         body: @mock_empty_response_body,
         status_code: 200
       }}
    end)

    assert {:ok, resource} = PageFetcherService.execute(@example_url)

    refute is_nil(resource.assets)
    refute is_nil(resource.links)
    assert resource.assets == []
    assert resource.links == []
  end

  test "execute/1 will return error when page not found" do
    expect(HTTPoison.BaseMock, :get, fn url ->
      refute is_nil(url)
      assert is_binary(url)

      {:ok,
       %HTTPoison.Response{
         body: "Page not found",
         status_code: 404
       }}
    end)

    assert {:error, "Page not found"} = PageFetcherService.execute(@example_url)
  end

  test "execute/1 will return error when url is invalid" do
    assert {:error,
            "The given url is invalid. Please, check if it is correct and follow the default pattern such as: 'http://example.com'."} =
             PageFetcherService.execute("")
  end
end
