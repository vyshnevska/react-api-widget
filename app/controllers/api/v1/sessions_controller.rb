#### Example of usage:
## (1) nano /etc/hosts
# 127.0.0.1 sub.virtual.local

## (2) Log in and get valid token
# curl -H "Content-Type: application/json" -X POST -d '{"user_login": {"email":"vyshnevska.n@gmail.com","password":"12345678"} }' localhost:3000/api/v1/sign-in.json

## (3) All Messages
# curl -H "Authorization: Token token=a4cd90986337ece181960596d2b97421" localhost:3000/api/v1/messages.json

## All Channels
# curl -H "Authorization: Token token=a4cd90986337ece181960596d2b97421" localhost:3000/api/v1/subscriptions/channels.json

## (4) Sign out
# curl -X DELETE -H "Authorization: Token token=4d9834d79d8fd98eac89bb7a772601ad" localhost:3000/api/v1/sign-out.json

class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate!, only: [:create]      # use token based auth
  skip_before_action :authenticate_user!, only: [:create] # skip devise auth

  def create
    resource = User.find_for_database_authentication(email: params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      auth_token = resource.generate_and_save_auth_token
!
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