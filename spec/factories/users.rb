FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Test user#{n}" }
    sequence(:password) { |n| "T1010#{n}" }
    sequence(:email)    { |m| "john.doe#{rand(m+100)}@example.com" }

    transient { subscriptions_count 1 }

    trait :authorized do
      auth_token { SecureRandom.hex }
      token_created_at { Time.zone.now + 2.minutes }
    end

    factory :user_with_channel do
      after(:build) do |u|
        u.channel = build(:channel, :full)
      end
    end
  end
end
