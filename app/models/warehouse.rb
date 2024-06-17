class Warehouse < ApplicationRecord
  has_many :stations
  has_many :power_banks

  validates :name, presence: true
  validates :address, presence: true
end