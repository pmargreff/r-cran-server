class Author < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :packages_authors, class_name: "PackagesAuthors"
  has_many :packages, through: :packages_authors
end
