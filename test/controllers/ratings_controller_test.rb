require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  attr_reader :rating, :user
  setup do
    @user = User.first
    @rating = ratings(:one)
  end

  def auth_header
    token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
    {Authorization: "#{token}"}
  end

  test "should get index" do
    get ratings_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create rating" do
    level = user.levels.create!(data:{cells:[]}, name:"test")
    value = 3.33
    assert_difference('Rating.count') do
      post ratings_url, headers: auth_header, params: { rating: { level_id: level.id, user_id: user.id, value: value } }, as: :json
    end

    assert parsed_response['value'] == value
    assert parsed_response['user_id'] == user.id
    assert parsed_response['level_id'] == level.id

    assert_response 201
  end

  test "should not create 2 ratings" do
    level = user.levels.create!(data:{cells:[]}, name:"test")
    value = 3.33
    assert_difference('Rating.count', 1) do
      post ratings_url, headers: auth_header, params: { rating: { level_id: level.id, user_id: user.id, value: value } }, as: :json
      post ratings_url, headers: auth_header, params: { rating: { level_id: level.id, user_id: user.id, value: value } }, as: :json
    end

    assert parsed_response['value'] == value
    assert parsed_response['user_id'] == user.id
    assert parsed_response['level_id'] == level.id

    assert_response 201
  end

  test "should show rating" do
    get rating_url(@rating), headers: auth_header, as: :json
    assert_response :success
  end

  test "should update rating" do
    level_id = @rating.level.id
    patch rating_url(@rating), headers: auth_header, params: { rating: { level_id: level_id, user_id: @rating.user_id, value: @rating.value } }, as: :json
    assert_response 200
  end

  test "should destroy rating" do
    assert_difference('Rating.count', -1) do
      delete rating_url(@rating), headers: auth_header, as: :json
    end

    assert_response 204
  end
end
