class Api::V1::MessagesController < Api::V1::BaseController

  skip_before_action :authenticate_user!
  skip_before_action :authenticate!

  before_action :check_current_user, only: :index


  def index
    render json: current_user, include: [:myMessages, :messagesToMe, :channel]
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

  def check_current_user
    unless current_user
      render json: { errors: [ { detail: 'No current user' } ] }, status: 411
      return
    end
  end

  # def current_user
  #   @memorized_current_user ||= User.find 7
  # end
end