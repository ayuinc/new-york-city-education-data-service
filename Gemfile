source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.1.1'
gem 'rails-api'
gem 'pg'
gem 'active_model_serializers'
gem 'pry-rails'
gem 'unicorn'
gem 'virtus'

group :development do
  gem 'guard-rspec', require: false
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
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
end

group :production do
  gem 'rails_12factor'
end
