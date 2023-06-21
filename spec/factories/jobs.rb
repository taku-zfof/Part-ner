FactoryBot.define do
  factory :job do
      association :user
      tytle {Faker::Lorem.characters(number:10) }
      introduction { Faker::Lorem.characters(number:500) }
      postal_code { Faker::Address.zip }
      prefecture_code{ 15 }
      other_address { Faker::Lorem.characters(number:20) }
      near_station { "" }
      near_station_line { "" }
      hourly_wage { 1000 }
      job_type { 10 }
      rondom_id { SecureRandom.base36 }
  end
end