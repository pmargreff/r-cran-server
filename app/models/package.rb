class Package < ApplicationRecord
  validates :name, :version, :md5, :author, presence: true
end
