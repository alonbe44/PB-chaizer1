# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Project Name : Power Banks Management System.

* Description :  Rails backend API to manage Power Banks and their distribution across
various locations, stations, and warehouses.
* 
* Ruby version : ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]

* Rails version : Rails 7.1.3.4

* System dependencies : 
Ruby 3.1.2p20
Rails 7.1.3.4
psql (PostgreSQL) 15.7

* Configuration :
git clone https://github.com/alonbe44/PB-chaizer1.git
cd PB-chaizer1
bundle install

* Database creation :

Edit config/database.yml with your database settings:
default: &default
  adapter: postgresql
  encoding: unicode
  database: your_database_name
  username: your_username
  password: your_password
  host: localhost
  port: 5432 # or your PostgreSQL port

* Database initialization

rails db:create
rails db:migrate
rails db:seed # if you have seed data

If you're starting fresh, you can combine these commands into one:

rails db:setup      # Creates database, runs migrations, and seeds (if seed file exists)

* Usage :
  * On Linux (Ubuntu/Debian) : 
  # Install rbenv
sudo apt-get update
sudo apt-get install rbenv

# Install Ruby

* On Linux (Ubuntu/Debian)
rbenv install <ruby_version>
rbenv global <ruby_version>

cd PB-chaizer1
* Install dependencies and set up the database:
bundle install
rails db:setup
* Start the Rails server:
rails server
 
*Bonus:
● Implement validations and error handling.
● Include search functionality with  Serial number Filters.
● Implement a simple front-end.

* How to run the test suite



