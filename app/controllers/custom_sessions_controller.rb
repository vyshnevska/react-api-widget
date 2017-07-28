class CustomSessionsController < Devise::SessionsController
  before_filter :before_login, only: :create

  def before_login
    user = User.find_by email: params[:user][:email]
    user.generate_and_save_auth_token!
  end
end