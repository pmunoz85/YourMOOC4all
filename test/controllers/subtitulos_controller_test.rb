require 'test_helper'

class SubtitulosControllerTest < ActionController::TestCase
  setup do
    @subtitulo = subtitulos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subtitulos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subtitulo" do
    assert_difference('Subtitulo.count') do
      post :create, subtitulo: { curso_id: @subtitulo.curso_id, idioma_id: @subtitulo.idioma_id }
    end

    assert_redirected_to subtitulo_path(assigns(:subtitulo))
  end

  test "should show subtitulo" do
    get :show, id: @subtitulo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subtitulo
    assert_response :success
  end

  test "should update subtitulo" do
    patch :update, id: @subtitulo, subtitulo: { curso_id: @subtitulo.curso_id, idioma_id: @subtitulo.idioma_id }
    assert_redirected_to subtitulo_path(assigns(:subtitulo))
  end

  test "should destroy subtitulo" do
    assert_difference('Subtitulo.count', -1) do
      delete :destroy, id: @subtitulo
    end

    assert_redirected_to subtitulos_path
  end
end
