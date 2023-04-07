# frozen_string_literal: true
require 'open-uri'

class GzipReader
  attr_accessor :url

  # receives a url/file to a compressed file returns decompressed content
  def call(url)
    @url = url

    content = fetch_content
    decompress(content)
  end

  private

  def fetch_content
    open(url) { |f| f.read }
  end

  def decompress(compressed_io)
    gzip_reader.decompress(compressed_io)
  end

  def gzip_reader
    ActiveSupport::Gzip
  end
end
