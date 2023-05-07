# **Page Fetcher**

This is a simple Elixir application that fetches a web page and extracts the URLs of all the images and links on the page. It uses the HTTPoison library to fetch the web page and the Floki library to parse the HTML and extract the URLs.

## **Installation 🔧**

To use this application, you'll need to have Elixir installed on your system. You can download it from the official website: https://elixir-lang.org/install.html

Once you have Elixir installed, you can clone this repository and run the following command in the root directory to install the dependencies:

```sh
mix deps.get
```

## **How it works 👨‍💻**

To use the PageFetcher module in your own code, you can call the fetch function with a URL as an argument. The function will return a tuple with the assets and links found on the page:


```elixir
iex> PageFetcher.fetch("https://example.com")
{:ok, %{
  assets: ["https://example.com/image.jpg", "https://example.com/logo.png"],
  links: ["https://example.com/", "https://example.com/about"]
}}
```

If the URL is invalid or the HTTP request fails, the function will return an error tuple:

```elixir
iex> PageFetcher.fetch("example.com")
{:error, "The given url is invalid. Please, check if it is correct and follow the default pattern such as: 'http://example.com'."}
```

Or when for some reason the page is unreachable, it will return the actual error from the page which can vary.

```elixir
iex> PageFetcher.fetch("https://example.com/some-not-existing-page")
{:error, "Page does not exists"}
```

## **Assumptions and Limitations 💡**

This implementation makes some assumptions and has some limitations:

* The implementation assumes that the web page is in HTML format and contains `<img>` and `<a>` tags with valid URLs in the src and href attributes. If the web page contains other types of assets or links, they will not be detected by this implementation. And if the page does not contains the expected tags, an empty list for these tags will be returned.

* The implementation uses the Floki library to parse the HTML and extract the URLs. If the HTML is malformed or not well-formed, the parsing may fail or return incorrect results.

* The implementation uses the HTTPoison library to fetch the web page. If the web page is behind a login or requires other authentication, the fetch request will fail.

* The implementation uses synchronous blocking IO, which means that it will block the current process while waiting for the HTTP request to complete. If the web page takes a long time to load, the function call may block for an extended period of time.

## **Future Work 🤖**

If I had more time, some work could be improved on this implementation in a few ways:

* There could  be added more error handling to handle edge cases such as malformed HTML or authentication errors. *(Obs: Error handlers are implemented for invalid urls or when page cannot be fetched)*

* Could be supported HTTP requests asynchronous using libraries such as Hackney or Finch to improve performance and prevent blocking.

* There could be implemented caching or other optimizations to reduce the number of HTTP requests made to the same URL.

## **Tests 🔬**

The best testing practices were used in this applicaition. It's a 100% tests covered, and it was completely developed using TDD. The library [TestWatch](https://github.com/lpil/mix-test.watch) made that posssible since it runs tests while coding!

Also, no web request is really made in the tests. The app uses the best practices for mocks by mimicking **behaviours**, which is strongly recommended in the elixir community and most languages. As provided by the library [Mox](https://github.com/dashbitco/mox).

To check coverage please type the following in the root folder of the app:

```sh
mix coveralls
```