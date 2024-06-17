class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :created_at, :updated_at

  has_many :stations
end