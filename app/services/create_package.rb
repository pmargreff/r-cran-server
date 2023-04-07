# frozen_string_literal: true
require "dcf"

class CreatePackage
  attr_accessor :content

  def call(content)
    @content = content

    Package.create(
      name: content["Package"],
      version: content["version"],
      md5: content["md5"],
      author: content["author"]
    )
  end
end
