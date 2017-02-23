class Api::V1::MessagesController < Api::V1::BaseController
  def index
    respond_with Message.all.order(created_at: :desc)
  end

  def create
    respond_with :api, :v1, Message.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:id, :content, :recipient_id, :status, :sender_id)
  end
end