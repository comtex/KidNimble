require 'test_helper'

class DirectorformsControllerTest < ActionController::TestCase
  setup do
    @directorform = directorforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:directorforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create directorform" do
    assert_difference('Directorform.count') do
      post :create, directorform: @directorform.attributes
    end

    assert_redirected_to directorform_path(assigns(:directorform))
  end

  test "should show directorform" do
    get :show, id: @directorform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @directorform
    assert_response :success
  end

  test "should update directorform" do
    put :update, id: @directorform, directorform: @directorform.attributes
    assert_redirected_to directorform_path(assigns(:directorform))
  end

  test "should destroy directorform" do
    assert_difference('Directorform.count', -1) do
      delete :destroy, id: @directorform
    end

    assert_redirected_to directorforms_path
  end
end
