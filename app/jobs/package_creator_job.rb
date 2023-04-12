class PackageCreatorJob < ApplicationJob
  queue_as :default

  def perform(server, partial_package)
    PackageProcessor.new.call(server, partial_package)

  # does not retry on unrecoverable errors
  rescue OpenURI::HTTPError
    logger.warn("Package #{name} not found!")
  rescue ActiveRecord::StatementInvalid
    logger.warn("Package #{name} malformed!")
  end
end
