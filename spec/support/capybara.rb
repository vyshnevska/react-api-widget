require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :timeout => 120)
end

Capybara.javascript_driver = :poltergeist

Capybara.default_selector = :css