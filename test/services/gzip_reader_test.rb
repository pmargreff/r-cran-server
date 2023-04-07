require "test_helper"
require "tempfile"

class GzipReaderTest < ActiveSupport::TestCase
  def setup
    @content = "some text"
    @file_path = "/tmp/file.gz"
    compressed_content = ActiveSupport::Gzip.compress(@content)

    Tempfile.open(@file_path, binmode: true) { |file| file.write(compressed_content) }
  end

  def teardown
    File.delete(@file_path)
  end

  test "read content from compressed file" do
    result = GzipReader.new().call(@file_path)

    assert_equal result, @content
  end
end
