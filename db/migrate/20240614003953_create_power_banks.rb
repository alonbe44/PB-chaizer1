class CreatePowerBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :power_banks do |t|
      t.string :serial_number, null: false, index: { unique: true }
      t.string :status, null: false
      t.references :station, foreign_key: true
      t.references :warehouse, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

