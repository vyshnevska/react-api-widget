module Authenticable

  def current_user
    user_token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    # hotfix of jsonp headers issue
    # user_token = params[:token]
    @current_user ||= User.find_by auth_token: user_token
  end
end