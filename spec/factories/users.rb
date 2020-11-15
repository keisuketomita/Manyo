FactoryBot.define do
  factory :user_case1, class: User do
    name { 'ユーザー1' }
    email { 'user1@hoge.jp' }
    password { 'hogehoge' }
    admin { 'false' }
  end
  factory :user_case2, class: User do
    name { 'ユーザー2' }
    email { 'user2@hoge.jp' }
    password { 'hogehoge' }
    admin { 'false' }
  end
  factory :user_case3, class: User do
    name { 'ユーザー3' }
    email { 'admin@hoge.jp' }
    password { 'hogehoge' }
    admin { 'true' }
  end

end
