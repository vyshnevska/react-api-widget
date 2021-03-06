require 'spec_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do

  describe '#index' do
    let(:send_request) { get :index, format: :json }

    specify 'returns unauthorized error' do
      send_request
      expect(response.status).to eq(401)
    end

    context 'with an authorized user' do
      let(:user) { create :user, :authorized }

      before do
        expect(controller).to receive(:authenticate!).and_return true
        expect(controller).to receive(:current_user).exactly(3).times.and_return user
      end

      specify 'basic json structure' do
        send_request

        expect(response.status).to           eq(200)

        expect(JSON.parse(response.body)).to  eq({
          'currentUser'        => { 'id'   => user.id.to_s,
                                    'name' => user.name },
          'myMessagesCount'    => '0',
          'subscriptionsCount' => '0',
          'username'           => user.username,
          'email'              => user.email,
          'friends'            => [],
          'full_name'          => nil,
          'channel'            => nil,
          'myMessages'         => [],
          'messagesToMe'       => []
        })
      end
    end
  end
end