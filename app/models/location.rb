class Location < ApplicationRecord
  has_many :stations

  validates :name, presence: true
  validates :address, presence: true
end