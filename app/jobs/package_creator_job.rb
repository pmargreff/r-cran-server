class PackageCreatorJob < ApplicationJob
  queue_as :default

  def perform(server, partial_package)
    full_package = fetch_package_description(server, partial_package["Package"], partial_package["Version"])
    create_package(partial_package, full_package)

  rescue OpenURI::HTTPError
    logger.warn("Package #{partial_package["Package"]} not found!")
  end

  private

  def create_package(partial_package, full_package)
    # full package does not contains md5sum information, so we merge it
    package = partial_package.merge(full_package)

    CreatePackage.new().call(package)
  end

  def fetch_package_description(server, name, version)
    FetchPackageDescription.new().call(server, name, version)
  end
end
