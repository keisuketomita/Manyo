# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# *** 管理ユーザー1人作成
name = "admin"
email = "admin@hoge.jp"
password = "hogehoge"
admin = "true"
User.create!(
  name: name,
  email: email,
  password: password,
  password_confirmation: password,
  admin: admin
)
# *** 一般ユーザー10人,タスク10件作成
@count = 2
10.times do |n|
  name = "hoge#{@count}"
  email = "#{name}@hoge.jp"
  password = "hogehoge"
  @user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )

    10.times do |n|
      name = Faker::Games::Pokemon.name
      detail = Faker::Games::Pokemon.name
      dead_line = "002020-11-30"
      status = "未着手"
      priority = 0
      user_id = @user.id
      Task.create!(
        name: name,
        detail: detail,
        dead_line: dead_line,
        status: status,
        priority: priority,
        user_id: user_id
      )
    end
  @count += 1
end


# *** ラベル作成
@count = 1
3.times do |n|
  name = " ラベル#{@count} "
  Label.create!(name: name)
  @count += 1
end


# *** 検索インデックス検証用
name = "test"
email = "test@hoge.jp"
password = "hogehoge"
@user = User.create!(
  name: name,
  email: email,
  password: password,
  password_confirmation: password
)

1000.times do |n|
  10.times do |n|
    name = Faker::Games::Pokemon.name
    detail = Faker::Games::Pokemon.name
    dead_line = "002020-11-30"
    status = "未着手"
    priority = 0
    user_id = @user.id
    Task.create!(
      name: name,
      detail: detail,
      dead_line: dead_line,
      status: status,
      priority: priority,
      user_id: user_id
    )
  end

  10.times do |n|
    name = Faker::Color.name
    detail = Faker::Color.name
    dead_line = "002020-12-30"
    status = "着手中"
    priority = 1
    user_id = @user.id
    Task.create!(
      name: name,
      detail: detail,
      dead_line: dead_line,
      status: status,
      priority: priority,
      user_id: user_id
    )
  end
end
