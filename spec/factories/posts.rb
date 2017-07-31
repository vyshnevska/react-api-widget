FactoryGirl.define do
  factory :post do
    sequence(:slug)  { |n| "post-slug#{n}" }
    sequence(:title) { |n| "post-title-#{n}" }
    sequence(:body)  { |n| "post-body-#{n}" }
    published true
    created_at Time.current

    trait :full do
      association :author, factory: :user_with_channel
    end
  end
end