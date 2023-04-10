# frozen_string_literal: true
class CreatePackage
  attr_accessor :remote_package

  def call(params)
    @params = params
    ActiveRecord::Base.transaction do
      license = find_or_create_license

      Package.create!(
        name:             params["Package"],
        title:            params["Title"],
        license:          license,
        md5:              params["MD5sum"],
        maintainer:       params["Maintainer"],
        dependencies:     params["Depends"], #TODO: add imports
        publication_date: params["Date/Publication"].to_datetime,
        version:          params["Version"],
        author:           params["Author"]
      )
    end
  end

  private

  def find_or_create_license
    License.find_or_create_by!(name: @params["License"])
  end
end
