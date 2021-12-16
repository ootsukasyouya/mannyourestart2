FactoryBot.define do
  factory :user do
    name { "test1" }
    email { "test1@email.com" }
    password { "test123" }
    password_confirmation { "test123" }
    admin { "false" }
  end

  factory :second_user, class: User do
    name { "test2" }
    email { "test2@test.com" }
    password { "test234" }
    password_confirmation { "test234" }
    admin { "false" }
  end

  factory :third_user, class: User do
    name { "admin_user" }
    email { "admin_user@mail.com" }
    password { "9999999" }
    admin { "true" }
  end
end
