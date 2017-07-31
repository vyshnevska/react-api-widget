FactoryGirl.define do
  factory :channel do
    sequence(:name)  { |n| "channel-name#{n}" }
    type 'public'
    active true
  end
end