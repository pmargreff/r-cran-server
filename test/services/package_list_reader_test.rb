require "test_helper"

class PackageListReaderTest < ActiveSupport::TestCase
  def setup
    @server = file_fixture("small_server/")
    @data=<<EOF
Package: A3
Version: 1.0.0
Depends: R (>= 2.15.0), xtable, pbapply
Suggests: randomForest, e1071
License: GPL (>= 2)
MD5sum: 027ebdd8affce8f0effaecfcd5f5ade2
NeedsCompilation: no

Package: AalenJohansen
Version: 1.0
Suggests: knitr, rmarkdown
License: GPL (>= 2)
MD5sum: d7eb2a6275daa6af43bf8a980398b312
NeedsCompilation: no

Package: AATtools
Version: 0.0.2
Depends: R (>= 3.6.0)
Imports: magrittr, dplyr, doParallel, foreach
License: GPL-3
MD5sum: bc59207786e9bc49167fd7d8af246b1c
NeedsCompilation: no

EOF
  end

  test "reads package list from small_server" do
    result = PackageListReader.new.call(@server)

    assert_equal result, @data
  end
end
