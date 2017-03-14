class Api::V1::MessagesController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  def index
    respond_with({
      messages: Message.all.order(created_at: :desc),
      channels: Channel.all.map{|channel| { key: channel.id, label: channel.name } }
    })
  end

  def create
    respond_with :api, :v1, Message.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:id, :content, :recipient_id, :status, :channel_id)
  end
end