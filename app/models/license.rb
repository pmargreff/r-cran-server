class License < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :packages
end
