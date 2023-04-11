class Package < ApplicationRecord
  validates :name, :md5, presence: true

  belongs_to :license

  has_many :packages_authors, class_name: "PackagesAuthors"
  has_many :authors, through: :packages_authors

  has_many :packages_dependencies, class_name: "PackagesDependencies"
  has_many :dependencies, through: :packages_dependencies

  has_many :versions, class_name: "PackageVersion"

  has_one :current_version,
    -> { order(created_at: :desc) },
    class_name: "PackageVersion"

  def r_dependency
    dependencies.where("name ILIKE 'R%'").first
  end

  def r_dependency_version
    r_dependency&.version
  end
end
