class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

ActionController::Renderers.add :json do |json, options|
  unless json.kind_of?(String)
    json = json.as_json(options) if json.respond_to?(:as_json)
    json = JSON.pretty_generate(json, options)
  end
  self.content_type ||= Mime::JSON
  json
end