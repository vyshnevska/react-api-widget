class Api::V1::SubscriptionsController < Api::V1::BaseController

  def create_channel
    channel = Channel.find_or_create_by(channel_params)
    render json: channel
  end

  def create
    subscription = Subscription.find_or_create_by(subscription_params)
    render json: subscription
  end

  def channels
    render json: Channel.active.by_popularity.limit(5)
  end

   private

  def channel_params
    params.require(:channel).permit(:user_id, :name, :active)
  end

  def subscription_params
    params.require(:subscription).permit(:user_id, :channel_id)
  end
end