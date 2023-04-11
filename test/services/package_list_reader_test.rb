require "test_helper"

class PackageListReaderTest < ActiveSupport::TestCase
  def setup
    @server = file_fixture("small_server/")
  end

  test "reads package list from small_server" do
    result = PackageListReader.new.call(@server)

    assert_equal result.size, 3

    assert_equal result.first["Package"], "A3"
    assert_equal result.second["Package"], "AalenJohansen"
    assert_equal result.third["Package"], "AATtools"
  end
end
