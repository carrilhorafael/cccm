require "test_helper"

class CultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cult = cults(:one)
  end

  test "should get index" do
    get cults_url, as: :json
    assert_response :success
  end

  test "should create cult" do
    assert_difference('Cult.count') do
      post cults_url, params: { cult: { date_of: @cult.date_of, description: @cult.description, responsible_name: @cult.responsible_name } }, as: :json
    end

    assert_response 201
  end

  test "should show cult" do
    get cult_url(@cult), as: :json
    assert_response :success
  end

  test "should update cult" do
    patch cult_url(@cult), params: { cult: { date_of: @cult.date_of, description: @cult.description, responsible_name: @cult.responsible_name } }, as: :json
    assert_response 200
  end

  test "should destroy cult" do
    assert_difference('Cult.count', -1) do
      delete cult_url(@cult), as: :json
    end

    assert_response 204
  end
end
