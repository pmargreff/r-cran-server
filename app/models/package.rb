class Package < ApplicationRecord
  validates :name, :version, :md5, :author, presence: true

  belongs_to :license
end
