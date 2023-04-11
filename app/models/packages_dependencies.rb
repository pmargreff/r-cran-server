class PackagesDependencies < ApplicationRecord
  belongs_to :package
  belongs_to :dependency
end
