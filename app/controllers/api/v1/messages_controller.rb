class Api::V1::MessagesController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  def index
    respond_with({
      messages: {
        to_me:   User.sorted_messages_for(current_user).map(&:for_react),
        from_me: User.sorted_messages_by(current_user).map(&:for_react)
      },
      channels: ( current_user.channel ? [{ key: current_user.channel.id, label: current_user.channel.name }] : []) #Channel.all.map{|channel| { key: channel.id, label: channel.name } }
    })
  end

  def create
    respond_with(Message.create(message_params).for_react, location: api_v1_messages_path)
  end

  def update
    message = Message.find params[:id]
    message.assign_attributes message_params

    respond_with :api, :v1, message.changed? ? message.save : message
  end

  private

  def message_params
    params.require(:message).permit(:id, :content, :recipient_id, :status, :channel_id)
  end
end