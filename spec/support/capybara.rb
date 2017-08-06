require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 120, js_errors: true, inspector: true)
end

Capybara.javascript_driver = :poltergeist
# Capybara.javascript_driver = :poltergeist_debug

Capybara.default_selector = :css
