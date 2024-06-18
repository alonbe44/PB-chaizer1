# Create admin user
require_relative '../config/environment'# db/seeds.rb

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
#http://localhost:3000/users
# Create warehouse
warehouse = Warehouse.find_or_create_by!(name: 'Main Warehouse', address: '123 Warehouse St')

# Create location
location = Location.find_or_create_by!(name: 'Downtown', address: '456 Main St')

# Create stations
station1 = Station.find_or_create_by!(name: 'Station 1', status: 'online', location: location)
station2 = Station.find_or_create_by!(name: 'Station 2', status: 'offline', warehouse: warehouse)

# Create power banks and assign them to station1
10.times do |i|
  PowerBank.find_or_create_by!(serial_number: "friend-#{i+2}", status: 'available', station: station1)
end

# Create power banks and assign them to the warehouse
5.times do |i|
  PowerBank.find_or_create_by!(serial_number: "friend-#{i+11}", status: 'available', warehouse: warehouse)
end
