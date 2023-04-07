require "test_helper"

class CreatePackageTest < ActiveSupport::TestCase
  def setup
    # replace with fixtures
    @params = {
      "Package" => "A3",
      "version" => "1.0.0",
      "md5" => "027ebdd8affce8f0effaecfcd5f5ade2",
      "author" => "Alice"
    }
  end

  test "creates a valid package" do
    result = CreatePackage.new().call(@params)

    assert result.valid?

    assert_equal Package.count, 1
    assert_equal @params["Package"], result.name
    assert_equal @params["version"], result.version
    assert_equal @params["md5"], result.md5
    assert_equal @params["author"], result.author
  end
end
