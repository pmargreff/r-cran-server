class PackageVersion < ApplicationRecord
  validates :version, presence: true

  belongs_to :package
end
