FactoryBot.define do
  factory :offer do
      association :job
      association :user
      content {Faker::Lorem.characters(number:100) }
  end
end