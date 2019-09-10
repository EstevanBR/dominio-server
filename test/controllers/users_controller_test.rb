require 'test_helper'
require 'jwt'

class UsersControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    @user = User.first
  end

  def auth_header
    token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
    {Authorization: "#{token}"}
  end
  #before do
  #end

  test "should get index" do
    get users_url, headers: auth_header, as: :json
    assert_response :success
  end

  test "should create user (without auth)" do
    user2 = users(:two)
    User.find_by_email!(user2.email).destroy

    assert_difference('User.count') do
      post users_url, params: { user: { email: user2.email, password: 'secret', password_confirmation: 'secret', username: user2.username } }, as: :json
    end
    assert_nil request.headers['Authorization']
    assert_response 201
  end

  test "should show user" do
    get user_url(user), headers: auth_header, as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(user), headers: auth_header, params: { user: { email: user.email, password: 'secret', password_confirmation: 'secret', username: user.username } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(user), headers: auth_header, as: :json
    end
    assert_response 204
  end

  test 'should destroy levels if user deleted' do
    levels_count = Level.where(user: user).count
    assert levels_count > 0

    assert_difference('Level.count', -levels_count) do
      delete user_url(user), headers: auth_header, as: :json
    end

    assert_response 204
  end

  test "shouldn't get index if not authenticated" do
    get users_url, headers: {}, as: :json
    assert_response :unauthorized
  end

  test "shouldn't show user if not authenticated" do
    get user_url(user), as: :json
    assert_response :unauthorized
  end

  test "shouldn't update user if not authenticated" do
    patch user_url(user), params: { user: { email: user.email, password: 'secret', password_confirmation: 'secret', username: user.username } }, as: :json
    assert_response :unauthorized
  end

  test "shouldn't destroy user if not authenticated" do
    assert_difference('User.count', 0) do
      delete user_url(user), as: :json
    end

    assert_response :unauthorized
  end
end
