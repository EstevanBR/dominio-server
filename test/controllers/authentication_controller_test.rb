require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "raises error when invalid credentials" do
    post authenticate_url, params: {}
    assert_response 401
    assert parsed_response == {"error"=>{"user_authentication"=>"invalid credentials"}}
  end

  test "returns token with valid credentials" do
    u = User.create!(email:"t@t.com", password:"t", username: "tt")
    post authenticate_url, params: { email: u.email, password: u.password }, as: :json
    assert_response 200
    assert parsed_response.keys.include?('auth_token')
    assert_equal JWT.decode(parsed_response['auth_token'], Rails.application.secrets.secret_key_base).dig(0,'user_id'), u.id
  end
end
