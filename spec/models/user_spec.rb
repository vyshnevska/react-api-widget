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

  describe '#messages' do
    specify {
      expect(user.messages.to_sql).to eql "SELECT \"messages\".* FROM \"messages\" WHERE \"messages\".\"recipient_id\" = #{user.id}"
    }
  end

  describe '#own_messages' do
    specify {
      expect(user.own_messages.to_sql).to eql "SELECT \"messages\".* FROM \"messages\" INNER JOIN \"channels\" ON \"messages\".\"channel_id\" = \"channels\".\"id\" WHERE \"channels\".\"user_id\" = #{user.id}"
    }
  end

  describe '#sorted_messages_for' do
    specify {
      expect(User.sorted_messages_for(user).to_sql).to end_with "WHERE \"messages\".\"recipient_id\" = #{user.id} AND (\"messages\".\"status\" != 'hidden') ORDER BY \"messages\".\"status\" DESC, \"messages\".\"created_at\" DESC"
    }
  end

  describe '#sorted_messages_by' do
    specify {
      expect(User.sorted_messages_by(user).to_sql).to end_with "WHERE \"channels\".\"user_id\" = #{user.id} AND (\"messages\".\"status\" != 'hidden') ORDER BY \"messages\".\"status\" DESC, \"messages\".\"created_at\" DESC"
    }
  end
end