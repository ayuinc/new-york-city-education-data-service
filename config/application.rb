require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
#
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NycEducationTest
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**/}')]
    config.autoload_paths += Dir[Rails.root.join('lib', '{**/}')]
  end
end
