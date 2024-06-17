class PowerBankSerializer < ActiveModel::Serializer
  attributes :id, :serial_number, :status, :created_at, :updated_at, :station_id, :warehouse_id, :user_id
end