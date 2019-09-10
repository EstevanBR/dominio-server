require 'test_helper'

class LevelsControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user, :level
  
  setup do
    @user = User.first
    @level = Level.first
  end
  
  def auth_header
    token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
    {Authorization: "#{token}"}
  end

  test 'should add level' do
    assert_difference('Level.count') do
      post levels_url, headers: auth_header, params: {level: {data:"test", name:"test"} }, as: :json
    end
    assert_response :success
  end

  test "shouldn't add level if unauthorized" do
    post levels_url, params: {}, as: :json
    assert_response :unauthorized
  end

  test "shouldn't add levels if name is blank" do
    assert_difference('Level.count', 0) do
      post levels_url, headers: auth_header, params: {level: {data: {cells:[]}} }, as: :json
    end
    
    assert parsed_response['name'].include?("can't be blank")
    assert_response :unprocessable_entity
  end

  test "shouldn't add levels if data is blank" do
    assert_difference('Level.count', 0) do
      post levels_url, headers: auth_header, params: {level: {name: "test"} }, as: :json
    end
    
    assert parsed_response['data'].include?("can't be blank")
    assert_response :unprocessable_entity
  end

  test "should render levels" do
    get levels_url, headers: auth_header#, params: {}, as: :json

    assert parsed_response == JSON.parse(Level.all.to_json)
    assert_response :success
  end

  test "should render level" do
    
    get level_url(level), headers: auth_header

    assert parsed_response == JSON.parse(level.to_json)

    assert_response :success
  end

  test "should update level" do
    put level_url(level), headers: auth_header, params: {level: {name: "asdf", data: {cells:[]}} }, as: :json
    assert level.reload.name == "asdf"
    assert_response :success
  end

  test "should patch level" do
    patch level_url(level), headers: auth_header, params: {level: {name: "fdsa", data: {cells:[]}} }, as: :json
    assert level.reload.name == "fdsa"
    assert_response :success
  end

  test "should destroy level" do
    assert_difference('Level.count', -1) do
      delete level_url(level), headers: auth_header
    end
    assert_response :success
  end
end
