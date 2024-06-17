class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.string :name, null: false
      t.string :status, null: false
      t.references :location, foreign_key: true
      t.references :warehouse, foreign_key: true

      t.timestamps
    end
  end
end
