#### Example of usage:
# # log-in and get valid token
# curl -H "Content-Type: application/json" -X POST -d '{"user_login": {"email":"vyshnevska.n@gmail.com","password":"12345678"} }' http://localhost:3000/api/v1/sign-in.json
# # get messages
# curl -H "Authorization: Token token=d957dc8860d18218a53b30a29d1e1c3d" http://localhost:3000/api/v1/messages.json
# # fails to get messages
# curl -H "Authorization: Token token=fake" http://localhost:3000/api/v1/messages.json
# #sign out
# curl -X DELETE -H "Authorization: Token token=20a1621f19c20056bf0f3087ce9d6970" http://localhost:3000/api/v1/sign-out.json

class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate!, only: [:create]      # use token based auth
  skip_before_action :authenticate_user!, only: [:create] # skip devise auth

  def create
    resource = User.find_for_database_authentication(email: params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      auth_token = resource.generate_auth_token
      render json: { auth_token: auth_token }
    else
      invalid_login_attempt
    end

  end

  def destroy
    resource = current_user
    resource.invalidate_auth_token
    head :ok
  end

  private

  def invalid_login_attempt
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
  end
end