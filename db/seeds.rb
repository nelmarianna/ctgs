# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#FTGS Staff is already in the system.
User.destroy_all

User.create!([{
  firstName: "greatest",
  lastName: "ever",
  employeeNumb: "13457898",
  loginID: "admin101",
  password: "admin101",
  type: "Staff",
  email:"staff@example.com"
}])
