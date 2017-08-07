source 'https://rubygems.org'

# gem 'rails', '4.2.7.1'
gem 'rails', '5.0.0'

# Don't upgrade to 0.21 yet because of:
# The PGconn, PGresult, and PGError constants are deprecated, and will be removed as of version 1.0.
# You should use PG::Connection, PG::Result, and PG::Error instead, respectively.
# more: https://github.com/rails/rails/issues/29521
gem 'pg', '0.20'

gem 'redis', '~> 3.3', '>=3.3.3'

# authentication, authorization, admin
gem 'devise'

# serialization
gem 'active_model_serializers', '0.10'

# GraphQL
gem 'graphql'
gem "graphiql-rails"

gem 'responders'

# frontend/markup
gem 'slim'
gem 'simple_form'

# fontend/assets
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'local_time'

# frontend/stylesheets
gem 'bootstrap-generators', '~> 3.3.4'
gem 'bootstrap-sass', '~>3.3.6'
gem 'sass-rails', '~> 5.0'

# frontend/javascript
gem 'jquery-rails'
gem 'react-rails'

# image uploads
gem 'carrierwave', '~> 1.0'
gem 'mini_magick' # uploaded images (e.g. avatar) processing

gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'pry'
  gem 'byebug'
  gem 'jasmine'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
  # gem 'quiet_assets'
end

group :test do
  gem 'factory_girl_rails'

  # issue: https://github.com/thoughtbot/factory_girl/pull/982
  gem 'factory_girl', git: 'https://github.com/thoughtbot/factory_girl.git', branch: 'master'

  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'

  gem "capybara"
  gem 'selenium-webdriver'
end