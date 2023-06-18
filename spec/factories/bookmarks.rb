FactoryBot.define do
  factory :bookmark do
      association :job
      association :user
  end
end