class Api::V1::BaseController < ApplicationController
  include Authenticable

  respond_to :json

  before_action :authenticate!

  private

  def authenticate!
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.where(auth_token: token).where("token_created_at >= ?", 1.month.ago).first
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { errors: [ { detail: 'Access denied' } ] }, status: 401
  end
end