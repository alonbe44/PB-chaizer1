class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  has_many :power_banks

  validates :name, presence: true
  validates :status, presence: true
  validate :power_banks_count_within_limit

  private

  def power_banks_count_within_limit
    if power_banks.size > 10
      errors.add(:power_banks, "cannot exceed 10")
    end
  end
end