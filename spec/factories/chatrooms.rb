FactoryBot.define do
  factory :chatroom do
      association :job
      association :user
      rondom_id { SecureRandom.base36 }
      hidden { false } 
  end
end