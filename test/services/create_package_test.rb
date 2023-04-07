require "test_helper"

class CreatePackageTest < ActiveSupport::TestCase
  def setup
    # TODO: replace with fixtures
    @params = {
      "Package" => "A3",
      "version" => "1.0.0",
      "md5" => "027ebdd8affce8f0effaecfcd5f5ade2",
      "author" => "Alice"
    }
  end

  test "create a package with valid params" do
    result = CreatePackage.new().call(@params)

    assert result.valid?

    assert_equal Package.count, 1
    assert_equal @params["Package"], result.name
    assert_equal @params["version"], result.version
    assert_equal @params["md5"], result.md5
    assert_equal @params["author"], result.author
  end

  test "does not create package on missing params" do
    result = CreatePackage.new().call({})

    refute result.valid?

    assert_equal Package.count, 0

    # TODO: refactor assertions https://stackoverflow.com/a/42618473/3687723
    # TODO: refactor validations to happen directly to the Package module
    assert result.errors.added? :name, :blank
    assert result.errors.added? :version, :blank
    assert result.errors.added? :md5, :blank
    assert result.errors.added? :author, :blank
  end
end
