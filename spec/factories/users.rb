FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Test user#{n}" }
    sequence(:password) { |n| "T1010#{n}" }
    sequence(:email)    { |m| "john.doe#{m-1}@example.com" }
  end
end
