# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 51.times do |n|
#   name = Faker::Games::Pokemon.name
#   detail = Faker::Games::Pokemon.name
#   dead_line = "002020-11-30"
#   status = "未着手"
#   priority = 0
#   Task.create!(name: name,
#                detail: detail,
#                dead_line: dead_line,
#                status: status,
#                priority: priority
#                )
# end
name = "hogea"
email = "hogea@hoge.jp"
password = "hogehoge"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password
             )

name = "hogeb"
email = "hogeb@hoge.jp"
password = "hogehoge"
admin = "true"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
             admin: admin
             )
