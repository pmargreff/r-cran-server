# frozen_string_literal: true

class PackageListReader
  attr_accessor :server

  PACKAGES_FILE = "PACKAGES.gz"

  def call(server)
    @server = server

    packages_path = @server + PACKAGES_FILE
    read_packages(packages_path)
  end

  private

  def read_packages(path)
    GzipReader.new.call(path)
  end
end
