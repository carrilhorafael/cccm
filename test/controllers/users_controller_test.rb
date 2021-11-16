require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { birthdate: @user.birthdate, branch: @user.branch, email: @user.email, is_baptized: @user.is_baptized, is_manager: @user.is_manager, is_master: @user.is_master, last_time_logged_at: @user.last_time_logged_at, location: @user.location, marital_status: @user.marital_status, member_since: @user.member_since, name: @user.name, password_digest: @user.password_digest, validation_token: @user.validation_token, validation_token_sent_at: @user.validation_token_sent_at } }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { birthdate: @user.birthdate, branch: @user.branch, email: @user.email, is_baptized: @user.is_baptized, is_manager: @user.is_manager, is_master: @user.is_master, last_time_logged_at: @user.last_time_logged_at, location: @user.location, marital_status: @user.marital_status, member_since: @user.member_since, name: @user.name, password_digest: @user.password_digest, validation_token: @user.validation_token, validation_token_sent_at: @user.validation_token_sent_at } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
