source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.1.1'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'active_model_serializers'
gem 'pry-rails'
gem 'unicorn'
gem 'virtus'

group :development do
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'guard-cucumber'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'rb-fsevent'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'foreman'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem "poltergeist"
  gem 'capybara'
  gem "capybara-webkit"
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end
