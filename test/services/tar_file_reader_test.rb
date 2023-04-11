require "test_helper"

class TarFileReaderTest < ActiveSupport::TestCase
  def setup
    @content = "world"
    @file_path = file_fixture("foo.tar.gz")
  end

  test "when file exists unpack and returns content" do
    result = TarFileReader.new.call(@file_path, "hello")

    assert_equal result, @content
  end

  test "when file does not exists returns nil" do
    result = TarFileReader.new.call(@file_path, "invalid")

    assert_nil result
  end
end

