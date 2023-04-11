# frozen_string_literal: true

class CreatePackage
  attr_accessor :remote_package

  def call(params)
    @params = params

    ActiveRecord::Base.transaction do
      license = find_or_create_license!
      authors = find_or_create_authors!

      package = create_package!(
        authors: authors,
        license: license
      )

      create_version!(package)

      package
    end
  end

  private

  def create_package!(license:, authors:)
    Package.create!(
      name:             @params["Package"],
      title:            @params["Title"],
      md5:              @params["MD5sum"],
      maintainer:       @params["Maintainer"],
      dependencies:     @params["Depends"], #TODO: add imports
      publication_date: @params["Date/Publication"].to_datetime,
      license:          license,
      authors:          authors
    )
  end

  def create_version!(package)
    package.versions.create(version: @params["Version"])
  end

  def find_or_create_license!
    License.find_or_create_by!(name: @params["License"])
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
end
