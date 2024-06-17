class StationSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :created_at, :updated_at, :location_id, :warehouse_id
end