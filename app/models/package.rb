class Package < ApplicationRecord
  validates :name, :version, :md5, presence: true

  belongs_to :license

  has_many :packages_authors, class_name: "PackagesAuthors"
  has_many :authors, through: :packages_authors
end
