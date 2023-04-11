class PackagesIndexer
  attr_accessor :server

  def call(server)
    @server = server

    remote_packages = read_packages_from_server

    # If the md5 hash exist considers it created and updated.
    # If the md5 hash does not exist but the package exists, update it.
    # If the package does not exists create it.
    remote_packages.each do |remote_package|
      next if package_exists?(remote_package)
      enqueue_package_create(remote_package)
    end
  end

  private

  def enqueue_package_create(remote_package)
    PackageCreatorJob.perform_later(@server, remote_package)
  end

  def package_exists?(remote_package)
    Package.exists?(md5: remote_package["MD5sum"])
  end

  def read_packages_from_server
    PackageListReader.new().call(@server)
  end
end

