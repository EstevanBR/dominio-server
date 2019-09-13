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
      post levels_url,
      headers: auth_header,
      params: {
        level: {
          data:{
            cells:[]
          },
          name:"test"
        }
      }, as: :json
    end
    assert_response :success
  end

  test "shouldn't add level if unauthorized" do
    post levels_url, params: {}, as: :json
    assert_response :unauthorized
  end

  test "shouldn't add levels if name is blank" do
    assert_difference('Level.count', 0) do
      post levels_url,
        headers: auth_header,
        params: {
          level: {
            data: {
              cells:[]
            }
          }
        }, as: :json
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
    assert Level.count > 0

    get levels_url, headers: auth_header#, params: {}, as: :json

    
    assert parsed_response.first.include? ("id")
    assert parsed_response.first.include? ("name")
    assert parsed_response.first.include? ("data")
    assert parsed_response.first.include? ("user_id")
    assert parsed_response.first.include? ("rating")

    assert_response :success
  end

  test "should render level" do
    
    get level_url(level), headers: auth_header
    
    assert parsed_response.include? ("id")
    assert parsed_response.include? ("name")
    assert parsed_response.include? ("data")
    assert parsed_response.include? ("user_id")
    assert parsed_response.include? ("rating")

    assert_response :success
  end

  test "should update level" do
    put level_url(level),
      headers: auth_header,
      params: {
        level: {
          name: "asdf",
          data: {cells:[]}
        }
      }, as: :json
    assert level.reload.name == "asdf"
    assert_response :success
  end

  test "should patch level" do
    patch level_url(level),
      headers: auth_header,
      params: {
        level: {
          name: "fdsa",
          data: {
            cells:[]
          }
        }
      }, as: :json
    assert level.reload.name == "fdsa"
    assert_response :success
  end

  test "should destroy level" do
    assert_difference('Level.count', -1) do
      delete level_url(level), headers: auth_header
    end
    assert_response :success
  end

  test 'should get rating, nil when no ratings' do
    level.ratings.destroy_all

    assert level.ratings.count == 0
    get level_url(level) + "/rating", headers: auth_header

    assert_nil parsed_response["rating"]
    assert_response :success
  end

  test 'should get rating, value when ratings' do
    level.ratings.destroy_all
    level.ratings.create!(value: 4.44, user_id: user.id)

    assert level.ratings.count == 1

    get level_url(level) + "/rating", headers: auth_header
    
    assert parsed_response["rating"].to_f == 4.44
    assert_response :success
  end
end
