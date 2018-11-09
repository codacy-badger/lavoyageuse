require 'test_helper'

class PlanControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get plan_show_url
    assert_response :success
  end

  test "should get create" do
    get plan_create_url
    assert_response :success
  end

end
