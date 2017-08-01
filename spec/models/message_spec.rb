require 'spec_helper'

RSpec.describe Message, type: :model do

  describe 'serialization, #to_h' do
    specify do
      expect(Message.new.to_h.keys).to eq(%i(id content status created_at))
    end
  end
end
