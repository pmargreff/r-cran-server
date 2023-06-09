# frozen_string_literal: true
class PackageProcessor
  def call(server, partial_package)
    name = partial_package["Package"]
    version = partial_package["Version"]

    full_package = fetch_package_description(server, name, version)
    create_package(partial_package, full_package)
  end

  private

  def create_package(partial_package, full_package)
    # full package does not contain md5sum information, so we merge it
    package = partial_package.merge(full_package)

    create_package_service = CreatePackage.new
    create_package_service.call(package)
  end

  def fetch_package_description(server, name, version)
    fetch_package_description_service = FetchPackageDescription.new
    fetch_package_description_service.call(server, name, version)
  end
end
