FactoryGirl.define do
  factory :subscription do
    after(:build) do |s, evaluator|
      s.user    = evaluator.user    || build_stubbed(:user)
      s.channel = evaluator.channel || build_stubbed(:channel)
    end
  end
end