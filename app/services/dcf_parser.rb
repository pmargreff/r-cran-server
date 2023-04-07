# frozen_string_literal: true
require "dcf"

class DcfParser
  attr_accessor :content

  def call(content)
    @content = content

    Dcf.parse(content)
  end
end
