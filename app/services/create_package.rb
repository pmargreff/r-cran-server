# frozen_string_literal: true

class CreatePackage
  attr_accessor :remote_package

  def call(params)
    @params = params

    ActiveRecord::Base.transaction do
      authors = find_or_create_authors!
      license = find_or_create_license!
      dependencies = find_or_create_dependencies!

      package = create_package!(
        authors: authors,
        license: license,
        dependencies: dependencies
      )

      create_version!(package)

      package
    end
  end

  private

  def create_package!(license:, authors:, dependencies:)
    Package.create!(
      name:             @params["Package"],
      title:            @params["Title"],
      md5:              @params["MD5sum"],
      maintainer:       @params["Maintainer"],
      publication_date: @params["Date/Publication"].to_datetime,
      license:          license,
      authors:          authors,
      dependencies:     dependencies
    )
  end

  def create_version!(package)
    package.versions.create(version: @params["Version"])
  end

  def find_or_create_authors!
    # sanitizes from author roles
    # ex: alice [aur, cre]
    authors = @params["Author"].gsub(/\[.*?\]/, "")

    authors.split(",").map do |name|
      # remove spaces or newlines
      name = name.strip

      Author.find_or_create_by!(name: name)
    end
  end

  def find_or_create_dependencies!
    dependencies = @params["Depends"]

    dependencies.split(",").map do |dependency|
      # extracts dependency version
      name, version = dependency.split(/[()]+/)
      name = name.strip
      version = version&.strip

      Dependency.find_or_create_by!(name: name, version: version)
    end
  end

  def find_or_create_license!
    License.find_or_create_by!(name: @params["License"])
  end
end
