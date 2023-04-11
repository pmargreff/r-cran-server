require "test_helper"

class DcfReaderTest < ActiveSupport::TestCase
  def setup
    #TODO: extract these strings to fixtures
    @packages_content =<<EOF
Package: A3
Version: 1.0.0
MD5sum: 027ebdd8affce8f0effaecfcd5f5ade2

Package: AalenJohansen
Version: 1.0
MD5sum: d7eb2a6275daa6af43bf8a980398b312
EOF

    @description_content =<<EOF
Package: AATtools
Title: Reliability and Scoring Routines for the Approach-Avoidance Task
Version: 0.0.2
EOF

  end

  test "parses a array of packages" do
    result = DcfReader.new.call(@packages_content)

    assert_equal result.size, 2

    assert_equal result.first["Package"], "A3"
    assert_equal result.first["Version"], "1.0.0"
    assert_equal result.first["MD5sum"], "027ebdd8affce8f0effaecfcd5f5ade2"

    assert_equal result.second["Package"], "AalenJohansen"
    assert_equal result.second["Version"], "1.0"
    assert_equal result.second["MD5sum"], "d7eb2a6275daa6af43bf8a980398b312"
  end

  test "parses a package" do
    result = DcfReader.new.call(@description_content)

    assert_equal result.size, 1

    assert_equal result.first["Package"], "AATtools"
    assert_equal result.first["Version"], "0.0.2"
    assert_equal result.first["Title"], "Reliability and Scoring Routines for the Approach-Avoidance Task"
  end
end
