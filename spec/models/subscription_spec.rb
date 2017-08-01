require 'spec_helper'

RSpec.describe Subscription, type: :model do

  describe 'serialization, #to_h' do
    let(:subscription) { build :subscription }

    specify do
      expect(subscription.to_h.keys).to eq(%i(id channel_id user_id messages_count))
    end
  end
end
