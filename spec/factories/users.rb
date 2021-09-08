FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user@gmail.com" }
    password { "123456" }
    admin { false }
  end
end