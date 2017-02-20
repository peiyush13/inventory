require 'test_helper'

class PurchaseAccountControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get bill" do
    get :bill
    assert_response :success
  end

  test "should get displayallpurchase" do
    get :displayallpurchase
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get search_company" do
    get :search_company
    assert_response :success
  end

  test "should get getpurchaseinfo" do
    get :getpurchaseinfo
    assert_response :success
  end

end
