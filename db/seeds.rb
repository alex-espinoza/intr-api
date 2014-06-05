# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: "alex@alex.com", password: "test1234")
User.create!(email: "brot@brot.com", password: "test1234")
User.create!(email: "treb@treb.com", password: "test1234Matv")

Internship.create!(title: "Professional Dog Walker", company: "Woofs")
Internship.create!(title: "Professional Cat Walker", company: "Meows")
Internship.create!(title: "Sidewalk Inspector", company: "Cements")
Internship.create!(title: "Post-It-Note Maker", company: "OfficeMax")

MatchedInternship.create!(user_id: 1, internship_id: 1)
MatchedInternship.create!(user_id: 1, internship_id: 3)
MatchedInternship.create!(user_id: 2, internship_id: 2)
MatchedInternship.create!(user_id: 3, internship_id: 2)
MatchedInternship.create!(user_id: 3, internship_id: 3)
MatchedInternship.create!(user_id: 3, internship_id: 4)
