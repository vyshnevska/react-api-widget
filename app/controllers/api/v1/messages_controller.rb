class Api::V1::MessagesController < Api::V1::BaseController

  # skip_before_action :authenticate_user!
  # skip_before_action :authenticate!

  before_action :check_current_user, only: :index


  def index
    render json: current_user, include: [:myMessages, :messagesToMe, :channel]
  end

  def create
    channel = Channel.find message_params[:channel_id]
    channel.subscribers.each do |subscriber|
      Message.create(message_params.merge(recipient_id: subscriber.id))
    end
    owner_message_copy = create_message_copy!

    respond_with(owner_message_copy, location: api_v1_messages_path)
  end

  def update
    message = Message.find params[:id]
    message.assign_attributes message_params

    respond_with :api, :v1, message.changed? ? message.save : message
  end

  private

  def message_params
    params.require(:message).permit(:content, :status, :channel_id)
  end

  def check_current_user
    unless current_user
      render json: { errors: [ { detail: 'No current user' } ] }, status: 411
      return
    end
  end

  def create_message_copy!
    Message.create(message_params.merge(recipient_id: current_user.id))
  end

end