require 'spec_helper'

RSpec.describe Api::V1::SubscriptionsController, type: :controller do
  describe 'requires authorization' do
    %i(create_channel create channels).each do |action_name|
      specify "before #{action_name} action" do
        get action_name, format: :json
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'with authorization' do
    before { expect(controller).to receive(:authenticate!).and_return true }

    describe '#channels' do
      let(:send_request) { get :channels, format: :json }

      context 'scopes call' do
        before { expect(Channel).to receive_message_chain(:active, :by_popularity, :limit).and_return [] }
        specify { send_request }
      end

      context 'results' do
        let!(:channel)  { create :channel }
        let!(:channel2) { create :channel, active: false }

        specify 'returns active channels' do
          send_request
          expect(response.status).to eq(200)
          expect(parse(response)).to eq([
              { 'id'=>channel.id, 'name'=>channel.name, 'image_url'=>channel.image_url, 'active'=>true }
            ])
        end
      end
    end

    describe '#create' do
      context 'with wrong params' do
        specify 'raises error' do
          expect{ post(:create, params: { channel: {user_id: 1 } }) }.to raise_error(ActionController::ParameterMissing)
        end
      end

      context 'with params' do
        let(:send_request) { post :create, params: { subscription: { user_id: 1, channel_id: 1 } },
                                  format: :json }

        specify { expect{ send_request }.to change{ Subscription.count }.by(1) }

        specify 'renders a correct json' do
          send_request
          sbscr = Subscription.last
          expect(parse(response)).to eq({
            "id"=>sbscr.id, "channel_id"=>1, "user_id"=>1, "messages_count"=>nil
          })
        end
      end
    end

    describe '#create_channel' do
       context 'with wrong params' do
        specify 'raises error' do
          expect{ post(:create_channel, params: { subscription: {user_id: 1 } }) }
            .to raise_error(ActionController::ParameterMissing)
        end
      end

      context 'with params' do
        let(:send_request) { post :create_channel, params: { channel: { user_id: 1, name: 'name', active: true }},
                                   format: :json }
        specify { expect{ send_request }.to change{ Channel.count }.by(1) }

        specify do
          send_request
          channel = Channel.last
          expect(parse(response)).to eq({
            "id"=>channel.id, 'name'=>'name', 'active'=> true, 'image_url'=>nil
          })
        end
      end
    end
  end

  private
    def parse(response)
      JSON.parse(response.body)
    end
end