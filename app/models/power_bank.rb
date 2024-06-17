class PowerBank < ApplicationRecord
  belongs_to :station, optional: true
  belongs_to :warehouse, optional: true
  belongs_to :user, optional: true

  validates :serial_number, presence: true, uniqueness: true
  validates :status, presence: true
  validate :station_power_banks_count_within_limit, if: -> { station.present? }

  private

  def station_power_banks_count_within_limit
    if station.power_banks.count >= 10
      errors.add(:station, "cannot have more than 10 power banks")
    end
  end
end