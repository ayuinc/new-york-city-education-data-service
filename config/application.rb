require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
Bundler.require(*Rails.groups)

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NewYorkCityEducationDataService
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**/}')]
    config.autoload_paths += Dir[Rails.root.join('lib', '{**/}')]
  end
end
