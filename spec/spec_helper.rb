require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  
  def test_sign_in(user)
    u = controller.sign_in(user)
    jar = ActionDispatch::Cookies::CookieJar.build(@request)
    jar.signed[:remember_token] = [user.id, user.auth_token]
    @request.cookies[:remember_token] = jar[:remember_token]
    u
  end
end
