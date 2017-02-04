require 'test_helper'

class ConcessionariesControllerTest < ActionController::TestCase
  setup do
    @concessionary = concessionaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concessionaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concessionary" do
    assert_difference('Concessionary.count') do
      post :create, concessionary: { name: @concessionary.name, phone: @concessionary.phone }
    end

    assert_redirected_to concessionary_path(assigns(:concessionary))
  end

  test "should show concessionary" do
    get :show, id: @concessionary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concessionary
    assert_response :success
  end

  test "should update concessionary" do
    patch :update, id: @concessionary, concessionary: { name: @concessionary.name, phone: @concessionary.phone }
    assert_redirected_to concessionary_path(assigns(:concessionary))
  end

  test "should destroy concessionary" do
    assert_difference('Concessionary.count', -1) do
      delete :destroy, id: @concessionary
    end

    assert_redirected_to concessionaries_path
  end
end
