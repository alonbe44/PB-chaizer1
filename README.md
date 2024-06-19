# Project Name:
Power Banks Management System

## Description:
This project is a Ruby on Rails backend API designed to efficiently manage Power Banks and their distribution across various locations, stations, and warehouses. It features CRUD operations on multiple entities, establishing relationships between them. The system includes user authentication for secure login, user permissions, and policies to control data access. The frontend interface is designed to be smooth and user-friendly, utilizing Bootstrap for styling.

## Technologies Used:
- Ruby version: ruby 3.1.2p20
- Rails version: Rails 7.1.3.4
- Database: PostgreSQL 15.7
- Frontend: Bootstrap 

## Owner:
- Owner: Abdelrahman Rasem : alonbe44@gmail.com

## System Dependencies:
Ensure you have the following installed:
- Ruby 3.1.2p20
- Rails 7.1.3.4
- PostgreSQL 15.7

## Configuration:
1. Clone the repository:
```
git clone https://github.com/alonbe44/PB-chaizer1.git
cd PB-chaizer1
```
2. Install dependencies:
3. Edit `config/database.yml` with your PostgreSQL database settings:
```
default: &default
  adapter: postgresql
  encoding: unicode
  database: your_database_name
  username: your_username
  password: your_password
  host: localhost
  port: 5432 # or your PostgreSQL port
```
## Database Setup:

### Initialize the database:
```
rails db:setup
```
This command will create the database, run migrations, and seed initial data if provided.


## Usage:
### On Linux (Ubuntu/Debian):
Install rbenv:
 ```
sudo apt-get update
sudo apt-get install rbenv
```
Install Ruby (replace <ruby_version> with your desired Ruby version):


```
rbenv install <ruby_version>
rbenv global <ruby_version>
```
Navigate to your project directory:
```
cd PB-chaizer1
```
Install dependencies and set up the database:

```
bundle install
rails db:setup
#Start the Rails server:
rails server
```
## Bonus Features:

* Implemented validations and error handling.
* Includes search functionality with Serial Number filters.
* Basic front-end implementation (Designed a smooth and user-friendly UI using Bootstrap).
* Implemented CRUD operations for multiple entities.
* Established relationships between entities in the database.
* User authentication for secure login.
* Implemented user permissions and policies for secure data access.
