require 'test_helper'

class HealthControllerTest < ActionDispatch::IntegrationTest
  test "health" do
    get health_url, as: :json
    byebug
    assert_response :ok
  end
end
