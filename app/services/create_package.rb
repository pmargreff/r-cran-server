# frozen_string_literal: true
class CreatePackage
  attr_accessor :remote_package

  def call(params)
    @params = params

    Package.create!(
      name:             params["Package"],
      title:            params["Title"],
      license:          params["License"],
      md5:              params["MD5sum"],
      maintainer:       params["Maintainer"],
      dependencies:     params["Depends"], #TODO: add imports
      publication_date: params["Date/Publication"].to_datetime,
      version:          params["Version"],
      author:           params["Author"]
    )
  end
end
