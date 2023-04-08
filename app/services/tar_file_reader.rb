# frozen_string_literal: true
require 'rubygems/package'

class TarFileReader
  attr_accessor :tar_file, :target_file

  # receives a tar file and return the target file if it exists
  def call(tar_file, target_file)
    @tar_file = tar_file
    @target_file = target_file

    content = nil

    begin
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(@tar_file))
      tar_extract.rewind # The extract has to be rewinded after every iteration
      tar_extract.each do |entry|

        if entry.file? && entry.full_name.end_with?(@target_file)
          content = entry.read
          break
        end
      end
    ensure
      # no matter what, always closes the file
      tar_extract.close
    end

    content
  end
end
