#### Example of usage:
# # log-in and get valid token
# curl -H "Content-Type: application/json" -X POST -d '{"user_login": {"email":"vyshnevska.n@gmail.com","password":"12345678"} }' http://api.lvh.me:3000/v1/sign-in.json
# {"auth_token":"ce39f096213278f03127fb350fca9d48"}
# # get messages
# curl -H "Authorization: Token token=4d9834d79d8fd98eac89bb7a772601ad" http://api.lvh.me:3000/v1/messages.json
# # fails to get messages
# curl -H "Authorization: Token token=fake" http://api.lvh.me:3000/v1/messages.json
# #sign out
# curl -X DELETE -H "Authorization: Token token=20a1621f19c20056bf0f3087ce9d6970" http://api.lvh.me:3000/v1/sign-out.json

class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate!, only: [:create]      # use token based auth
  skip_before_action :authenticate_user!, only: [:create] # skip devise auth

  def create
    resource = User.find_for_database_authentication(email: params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      auth_token = resource.generate_auth_token_and_save!
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