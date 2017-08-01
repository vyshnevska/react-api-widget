require 'spec_helper'

class ApplicationController < ActionController::Base
  include Authenticable
end

RSpec.describe ApplicationController do
  controller(ApplicationController) {}

  let(:user) { FactoryGirl.create :user }

  describe "#current_user" do
    before do
      request.headers["Authorization"] = "Token token=" + user.auth_token
      expect(controller).to receive(:request).and_return request
    end

    it "returns the user from the authorization header" do
      expect(controller.current_user.auth_token).to eql user.auth_token
    end
  end
end