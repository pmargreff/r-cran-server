# frozen_string_literal: true
require "dcf"

class DcfReader
  attr_accessor :content

  def call(content)
    @content = content

    Dcf.parse(content)
  end
end
