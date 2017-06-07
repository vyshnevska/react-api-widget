class Api::V1::MessagesController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  # skip_before_action :authenticate!

  def index
    # current_user ||= User.find 7
    render json: current_user, include: [:my_messages, :messages_to_me, :channel]
  end

  def create
    respond_with(Message.create(message_params).for_react, location: api_v1_messages_path)
  end

  # def show
  #   render json: Message.find(params[:id])
  # end

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