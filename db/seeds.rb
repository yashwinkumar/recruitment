# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


hm = User.new(email: 'hm@example.com', password: '12341234', password_confirmation: '12341234')
hm.save(validate: false)
hm.add_role :hm

consultant = User.new(email: 'consultant@example.com', password: '12341234', password_confirmation: '12341234')
consultant.save(validate: false)
consultant.add_role :consultant

candidate = User.new(email: 'candidate@example.com', password: '12341234', password_confirmation: '12341234')
candidate.save(validate: false)
candidate.add_role :candidate

