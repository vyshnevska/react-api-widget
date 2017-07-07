class CustomSessionsController < Devise::SessionsController
  before_filter :before_login, only: :create

  def before_login
    user = User.find_by email: params[:user][:email]
    user.generate_auth_token_and_save!
  end
end