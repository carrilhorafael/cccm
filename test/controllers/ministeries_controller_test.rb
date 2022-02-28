require "test_helper"

class MinisteriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ministery = ministeries(:one)
  end

  test "should get index" do
    get ministeries_url, as: :json
    assert_response :success
  end

  test "should create ministery" do
    assert_difference('Ministery.count') do
      post ministeries_url, params: { ministery: { church_id: @ministery.church_id, description: @ministery.description, name: @ministery.name } }, as: :json
    end

    assert_response 201
  end

  test "should show ministery" do
    get ministery_url(@ministery), as: :json
    assert_response :success
  end

  test "should update ministery" do
    patch ministery_url(@ministery), params: { ministery: { church_id: @ministery.church_id, description: @ministery.description, name: @ministery.name } }, as: :json
    assert_response 200
  end

  test "should destroy ministery" do
    assert_difference('Ministery.count', -1) do
      delete ministery_url(@ministery), as: :json
    end

    assert_response 204
  end
end
