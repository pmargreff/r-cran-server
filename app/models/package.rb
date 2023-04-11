class Package < ApplicationRecord
  validates :name, :md5, presence: true

  belongs_to :license

  has_many :packages_authors, class_name: "PackagesAuthors"
  has_many :authors, through: :packages_authors
  has_many :versions, class_name: "PackageVersion"

  has_one :current_version, -> { order(created_at: :desc) }, class_name: "PackageVersion"
end
