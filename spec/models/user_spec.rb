require 'spec_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'serialization, #to_h' do
    specify do
      expect(user.to_h).to match({  myMessagesCount: '0',
                                    subscriptionsCount: '0',
                                    username: user.username,
                                    email: user.email,
                                    friends: [],
                                    full_name: nil,
                                    currentUser: { id: user.id.to_s, name: user.name }
      })
    end
  end
end
