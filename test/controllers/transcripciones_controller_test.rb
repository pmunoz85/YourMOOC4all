require 'test_helper'

class TranscripcionesControllerTest < ActionController::TestCase
  setup do
    @transcripcion = transcripciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transcripciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transcripcion" do
    assert_difference('Transcripcion.count') do
      post :create, transcripcion: { curso_id: @transcripcion.curso_id, idioma_id: @transcripcion.idioma_id }
    end

    assert_redirected_to transcripcion_path(assigns(:transcripcion))
  end

  test "should show transcripcion" do
    get :show, id: @transcripcion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transcripcion
    assert_response :success
  end

  test "should update transcripcion" do
    patch :update, id: @transcripcion, transcripcion: { curso_id: @transcripcion.curso_id, idioma_id: @transcripcion.idioma_id }
    assert_redirected_to transcripcion_path(assigns(:transcripcion))
  end

  test "should destroy transcripcion" do
    assert_difference('Transcripcion.count', -1) do
      delete :destroy, id: @transcripcion
    end

    assert_redirected_to transcripciones_path
  end
end
