FactoryBot.define do
  factory :user do
      name {Faker::Lorem.characters(number:5) }
      email { Faker::Internet.email}
      password { Faker::Lorem.characters(number:8) }
      sex { 2 }
      age { 30 }
      prefecture { Faker::Number.between(from: 1, to: 47)}
      introduction { Faker::Lorem.characters(number:500) }
      account_name{ SecureRandom.base36 }
  end
end