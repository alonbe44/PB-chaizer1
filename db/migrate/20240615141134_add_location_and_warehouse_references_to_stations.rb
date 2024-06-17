class AddLocationAndWarehouseReferencesToStations < ActiveRecord::Migration[6.0]
  def change
    unless column_exists? :stations, :location_id
      add_reference :stations, :location, foreign_key: true
    end

    unless column_exists? :stations, :warehouse_id
      add_reference :stations, :warehouse, foreign_key: true
    end
  end
end