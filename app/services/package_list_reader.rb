# frozen_string_literal: true

class PackageListReader
  attr_accessor :server

  PACKAGES_FILE = "PACKAGES.gz"

  def call(server)
    @server = server

    packages_path = @server + PACKAGES_FILE
    content = read_packages(packages_path)
    parse_packages(content)
  end

  private

  def read_packages(path)
    GzipReader.new.call(path)
  end

  def parse_packages(content)
    DcfReader.new.call(content)
  end
end
