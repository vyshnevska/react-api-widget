FactoryGirl.define do
  factory :channel do
    sequence(:name)  { |n| "channel-name#{n}" }
    type 'public'
    active true

    trait :full do
      after(:build) do |ch|
        ch.subscriptions << build(:subscription)
      end
    end
  end
end