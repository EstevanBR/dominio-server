require 'test_helper'

class HealthControllerTest < ActionDispatch::IntegrationTest
  test "health" do
    get health_url, as: :json
    assert parsed_response == JSON.parse({STATUS: "UP"}.to_json)
    assert_response :ok
  end
end
