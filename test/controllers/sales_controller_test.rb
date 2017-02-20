require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get bill" do
    get :bill
    assert_response :success
  end

  test "should get displaybill" do
    get :displaybill
    assert_response :success
  end

end
