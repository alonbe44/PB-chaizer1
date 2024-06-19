require_relative '../config/environment'

# Create admin user
admin = User.find_or_create_by!(email: 'admin12@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'admin'
end

# Create normal user
normal_user = User.find_or_create_by!(email: 'user@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = 'normal'
end

# Create warehouse
warehouse = Warehouse.find_or_create_by!(name: 'Main Warehouse', address: '123 Warehouse St')

# Create location
location = Location.find_or_create_by!(name: 'Downtown', address: '456 Main St')

# Create stations
station1 = Station.find_or_create_by!(name: 'Station 1', status: 'online', location: location)
station2 = Station.find_or_create_by!(name: 'Station 2', status: 'offline', warehouse: warehouse)

# Ensure station1 has exactly 10 power banks
2.times do |i|
  serial_number = "PB-#{i + 1}"
  PowerBank.find_or_create_by!(serial_number: serial_number, status: 'available', station: station1)
end

# Ensure warehouse has exactly 5 power banks
5.times do |i|
  serial_number = "PB-#{i + 11}"
  PowerBank.find_or_create_by!(serial_number: serial_number, status: 'available', warehouse: warehouse)
end

# Ensure unique power banks are created with specific serial numbers
PowerBank.find_or_create_by!(serial_number: "unique_serial_number_1", status: 'available', station: station1)
PowerBank.find_or_create_by!(serial_number: "unique_serial_number_2", status: 'available', station: station1)
