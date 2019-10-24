ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def parsed_response
    print(JSON.parse(response.body))
    JSON.parse(response.body)
  end

  def json_fixture(name)
    File.read(Rails.root.to_s + "/test/fixtures/json/#{name}.json")
  end
end
