# frozen_string_literal: true

require 'open-uri'

class FetchPackageDescription
  attr_accessor :server_uri, :name, :version

  DESCRIPTION_FILE_NAME = "/DESCRIPTION"

  def call(server_uri, name, version)
    @server_uri = server_uri
    @name = name
    @version = version

    description = nil

    # receives a file_url and return a temp file that exists just inside the block
    # with a copy of the url content that
    with_temp_file(file_url) do |tmp_file|
      description_dcf = find_description(tmp_file.path)
      description = read_dcf(description_dcf)
    end

    description
  end

  private

  def file_url
    "#{@server_uri}/#{@name}_#{@version}.tar.gz"
  end

  def find_description(file_path)
    TarFileReader.new.call(file_path, DESCRIPTION_FILE_NAME)
  end

  def read_dcf(content)
    DcfReader.new.call(content).first
  end

  # abstract temp file handling (copying, closing and deleting) so it does not leaks
  def with_temp_file(file_url)
    tmp_file = Tempfile.new(file_url)
    tmp_file.binmode

    begin
      open(file_url) do |remote_file|
        tmp_file.write(remote_file.read)
      end

      tmp_file.close

      yield(tmp_file)
    ensure
      tmp_file.unlink   # deletes the temp file
    end
  end
end
