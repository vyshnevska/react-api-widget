FactoryGirl.define do
  factory :channel do
    sequence(:name)  { |n| "channel-name#{n}" }
    type 'public'
    active true

    transient { subscriptions_count 1 }

    trait :full do
      image { File.new('db/fixtures/images/simple_image.jpg', 'r') }

      after(:stub) do |channel, evaluator|
        channel.stub(:subscriptions).and_return(FactoryGirl.build_stubbed_list(:subscription,
          evaluator.subscriptions_count, channel: channel)
        )
      end
    end
  end
end