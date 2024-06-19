# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { "admin@example.com" }
    password { "password" }
    role { "admin" }

    trait :normal_user do
      email { "user@example.com" }
      password { "password" }
      role { "normal" }
    end

    trait :admin do
      email { "admin@example.com" }
      password { "password" }
      role { "admin" }
    end
  end
end
