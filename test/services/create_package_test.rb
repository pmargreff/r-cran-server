require "test_helper"

class CreatePackageTest < ActiveSupport::TestCase
  def setup
    @params = {
      "Package"=>"AalenJohansen",
      "Version"=>"1.0",
      "License"=>"GPL (>= 2)",
      "MD5sum"=>"d7eb2a6275daa6af43bf8a980398b312",
      "NeedsCompilation"=>"no",
      "Type"=>"Package",
      "Title"=>"Conditional Aalen-Johansen Estimation",
      "Maintainer"=>"Martin Bladt <martinbladt@math.ku.dk>",
      "Encoding"=>"UTF-8",
      "Depends" => "R (>= 3.6.0)",
      "Imports" => "magrittr, dplyr, doParallel, foreach",
      "Packaged"=>"2023-02-28 18:01:12 UTC; martinbladt",
      "Author"=>"Martin Bladt [aut, cre], Christian Furrer [aut]",
      "Repository"=>"CRAN",
      "Date/Publication"=>"2023-03-01 10:42:09 UTC"
    }
  end

  test "create a package with valid params" do
    result = CreatePackage.new().call(@params)

    assert result.valid?

    # package assertions
    assert_equal Package.count, 1
    assert_equal @params["Package"], result.name
    assert_equal @params["Title"], result.title
    assert_equal @params["MD5sum"], result.md5
    assert_equal @params["Maintainer"], result.maintainer
    assert_equal @params["Depends"], result.dependencies
    assert_equal @params["Date/Publication"].to_datetime, result.publication_date
    assert_equal @params["Version"], result.version
    assert_equal @params["Author"], result.author

    # license assertions
    assert_equal License.count, 1
    assert_equal @params["License"], result.license.name
  end
end
