require 'capybara/rails'
require 'capybara/rspec'

Capybara.default_selector = :css


module CapybaraHelpers
  def capybara_login_user(user, options = {})
    visit new_user_session_path

    fill_in_login_form(user, options)
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  def fill_in_login_form(user, options = {})
    fill_in 'user_email',    with: user.email
    fill_in 'user_password', with: user.password
  end

  def capybara_logout_user
    find('#sign-out-trigger').click
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers
end