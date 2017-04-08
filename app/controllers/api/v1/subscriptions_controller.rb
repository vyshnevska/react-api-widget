class Api::V1::SubscriptionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  def create_channel
    channel = Channel.create(channel_params)

    respond_with(
      { channel: { id: channel.id, name: channel.name, active: channel.active } },
      location: api_v1_subscriptions_path
    )
  end

  def create
    respond_with(Subscription.create(subscription_params), location: api_v1_subscriptions_path)
  end

  def channels
    respond_with :api, :v1, Channel.active.by_popularity.map(&:for_react)
  end

   private

  def channel_params
    params.require(:channel).permit(:user_id, :name, :active)
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :channel_id)
  end
end