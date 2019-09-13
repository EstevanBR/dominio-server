require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user
  setup do
    @user = User.first
    @favorite = favorites(:one)
  end

  def auth_header
    token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
    {Authorization: "#{token}"}
  end

  test "should get index" do
    get favorites_url, headers:auth_header, as: :json
    assert_response :success
  end

  test "should create favorite" do
    level = user.levels.create!(data:{cells:[]}, name:"test")

    assert_difference('Favorite.count') do
      post favorites_url, headers:auth_header, params: { favorite: { level_id: level.id, user_id: user.id } }, as: :json
    end

    assert_response 201
  end

  test "should not create 2 favorites" do
    level = user.levels.create!(data:{cells:[]}, name:"test")

    assert_difference('Favorite.count', 1) do
      post favorites_url, headers:auth_header, params: { favorite: { level_id: level.id, user_id: user.id } }, as: :json
      post favorites_url, headers:auth_header, params: { favorite: { level_id: level.id, user_id: user.id } }, as: :json
    end

    assert_response 201
  end

  test "should show favorite" do
    get favorite_url(@favorite), headers:auth_header, as: :json
    assert_response :success
  end

  test "should update favorite" do
    patch favorite_url(@favorite), headers:auth_header, params: { favorite: { level_id: @favorite.level_id, user_id: @favorite.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy favorite" do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@favorite), headers:auth_header, as: :json
    end

    assert_response 204
  end
end
