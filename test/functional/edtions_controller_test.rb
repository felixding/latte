require 'test_helper'

class EdtionsControllerTest < ActionController::TestCase
  setup do
    @edtion = edtions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:edtions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create edtion" do
    assert_difference('Edtion.count') do
      post :create, edtion: @edtion.attributes
    end

    assert_redirected_to edtion_path(assigns(:edtion))
  end

  test "should show edtion" do
    get :show, id: @edtion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @edtion.to_param
    assert_response :success
  end

  test "should update edtion" do
    put :update, id: @edtion.to_param, edtion: @edtion.attributes
    assert_redirected_to edtion_path(assigns(:edtion))
  end

  test "should destroy edtion" do
    assert_difference('Edtion.count', -1) do
      delete :destroy, id: @edtion.to_param
    end

    assert_redirected_to edtions_path
  end
end
