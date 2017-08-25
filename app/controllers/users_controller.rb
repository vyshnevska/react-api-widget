class UsersController < ApplicationController

  def support_message
    user            = User.find params[:id]
    support_channel = Channel.support.last

    Subscription.find_or_create_by(channel: support_channel, user: user)
    Message.create(content: params[:content] || 'Welcome!', channel: support_channel, recipient_id: user.id)

    redirect_to :back
  end

end