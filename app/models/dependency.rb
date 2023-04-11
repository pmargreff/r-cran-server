class Dependency < ApplicationRecord
  validates :name, presence: true

  has_many :packages_dependencies, class_name: "PackagesDependencies"
  has_many :packages, through: :packages_dependencies
end
