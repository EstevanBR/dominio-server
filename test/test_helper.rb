ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :users
  fixtures :levels

  # Add more helper methods to be used by all tests here...
  def parsed_response
    JSON.parse(response.body)
  end
end
