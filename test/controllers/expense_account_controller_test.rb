require 'test_helper'

class ExpenseAccountControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get display" do
    get :display
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
