class CustomSessionsController < Devise::SessionsController
  before_action :before_login, only: :create

  def before_login
    user = User.find_by_email(params[:user][:email])

    unless user
      flash[:error] = 'Invalid email or password'
      return redirect_to root_path
    end
    user.generate_and_save_auth_token!
  end
end