defmodule UtilsTest do
  use ExUnit.Case, async: true

  @valid_example_url "https://example.com"
  @invalid_example_url "example.com"

  test "validate_url/1 when url is valid returns ok" do
    assert {:ok, :valid} == Utils.validate_url(@valid_example_url)
  end

  test "validate_url/1 when url is invalid returns invalid" do
    assert {:error, :invalid} == Utils.validate_url(@invalid_example_url)
  end

  test "validate_url/1 when url is empty returns invalid" do
    assert {:error, :invalid} == Utils.validate_url("")
  end

  test "validate_url/1 when url is nil returns invalid" do
    assert {:error, :invalid} == Utils.validate_url(nil)
  end
end
