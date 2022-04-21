require "test_helper"

class ProselytesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proselyte = proselytes(:one)
  end

  test "should get index" do
    get proselytes_url, as: :json
    assert_response :success
  end

  test "should create proselyte" do
    assert_difference('Proselyte.count') do
      post proselytes_url, params: { proselyte: { church_id: @proselyte.church_id, name: @proselyte.name, phone: @proselyte.phone, proselytized_at: @proselyte.proselytized_at } }, as: :json
    end

    assert_response 201
  end

  test "should show proselyte" do
    get proselyte_url(@proselyte), as: :json
    assert_response :success
  end

  test "should update proselyte" do
    patch proselyte_url(@proselyte), params: { proselyte: { church_id: @proselyte.church_id, name: @proselyte.name, phone: @proselyte.phone, proselytized_at: @proselyte.proselytized_at } }, as: :json
    assert_response 200
  end

  test "should destroy proselyte" do
    assert_difference('Proselyte.count', -1) do
      delete proselyte_url(@proselyte), as: :json
    end

    assert_response 204
  end
end
