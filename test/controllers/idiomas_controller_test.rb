require 'test_helper'

class IdiomasControllerTest < ActionController::TestCase
  setup do
    @idioma = idiomas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:idiomas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idioma" do
    assert_difference('Idioma.count') do
      post :create, idioma: { descripcion: @idioma.descripcion }
    end

    assert_redirected_to idioma_path(assigns(:idioma))
  end

  test "should show idioma" do
    get :show, id: @idioma
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idioma
    assert_response :success
  end

  test "should update idioma" do
    patch :update, id: @idioma, idioma: { descripcion: @idioma.descripcion }
    assert_redirected_to idioma_path(assigns(:idioma))
  end

  test "should destroy idioma" do
    assert_difference('Idioma.count', -1) do
      delete :destroy, id: @idioma
    end

    assert_redirected_to idiomas_path
  end
end
