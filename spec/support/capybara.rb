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

  def capybara_fill_in_post_form(options = {})
    fill_in 'post_title', with: options[:title] || 'test post title'
    fill_in 'post_slug',  with: options[:slug]  || 'test-post-slug'
    fill_in 'post_body',  with: options[:body]  || 'body for a test post'

    find(:select, "post_author_id").find(:xpath, 'option[2]').select_option
    find(:css, "#post_published").set(true)

    # fill_in 'post_top_image', with: options[:body] || 'body for a test post'
    click_button 'Create Post'
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers
end