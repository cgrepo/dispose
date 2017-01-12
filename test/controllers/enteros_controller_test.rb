require 'test_helper'

class EnterosControllerTest < ActionController::TestCase
  setup do
    @entero = enteros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enteros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entero" do
    assert_difference('Entero.count') do
      post :create, entero: { quantity: @entero.quantity, service: @entero.service, taxpayer: @entero.taxpayer, unit: @entero.unit }
    end

    assert_redirected_to entero_path(assigns(:entero))
  end

  test "should show entero" do
    get :show, id: @entero
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entero
    assert_response :success
  end

  test "should update entero" do
    patch :update, id: @entero, entero: { quantity: @entero.quantity, service: @entero.service, taxpayer: @entero.taxpayer, unit: @entero.unit }
    assert_redirected_to entero_path(assigns(:entero))
  end

  test "should destroy entero" do
    assert_difference('Entero.count', -1) do
      delete :destroy, id: @entero
    end

    assert_redirected_to enteros_path
  end
end
