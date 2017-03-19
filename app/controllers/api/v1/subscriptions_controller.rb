class Api::V1::SubscriptionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  def create_channel
    channel = Channel.create(channel_params)
    respond_with({ channel: { name: channel.name, active: channel.active }}, location: api_v1_subscriptions_path)
  end


   private

  def channel_params
    params.require(:channel).permit(:user_id, :name, :active)
  end
end