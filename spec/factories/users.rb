FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Test user#{n}" }
    sequence(:password) { |n| "T1010#{n}" }
    sequence(:email)    { |m| "john.doe#{m-1}@example.com" }

    trait :authorized do
      auth_token { SecureRandom.hex }
      token_created_at { Time.zone.now + 2.minutes }
    end

  end
end
