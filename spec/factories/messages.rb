FactoryBot.define do
  factory :message do
      association :chatroom
      association :user
      content { Faker::Lorem.characters(number:20) }
      read_status { false }
  end
end