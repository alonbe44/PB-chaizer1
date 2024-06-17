class WarehouseSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :created_at, :updated_at

  has_many :stations
  has_many :power_banks
end