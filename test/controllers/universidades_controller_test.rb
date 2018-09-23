require 'test_helper'

class UniversidadesControllerTest < ActionController::TestCase
  setup do
    @universidad = universidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:universidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create universidad" do
    assert_difference('Universidad.count') do
      post :create, universidad: { nombre: @universidad.nombre }
    end

    assert_redirected_to universidad_path(assigns(:universidad))
  end

  test "should show universidad" do
    get :show, id: @universidad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @universidad
    assert_response :success
  end

  test "should update universidad" do
    patch :update, id: @universidad, universidad: { nombre: @universidad.nombre }
    assert_redirected_to universidad_path(assigns(:universidad))
  end

  test "should destroy universidad" do
    assert_difference('Universidad.count', -1) do
      delete :destroy, id: @universidad
    end

    assert_redirected_to universidades_path
  end
end
