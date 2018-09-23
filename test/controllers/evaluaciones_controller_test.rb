require 'test_helper'

class EvaluacionesControllerTest < ActionController::TestCase
  setup do
    @evaluacion = evaluaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluacion" do
    assert_difference('Evaluacion.count') do
      post :create, evaluacion: { curso_id: @evaluacion.curso_id, expresion: @evaluacion.expresion, expresion_pregunta23: @evaluacion.expresion_pregunta23, expresion_pregunta24: @evaluacion.expresion_pregunta24, expresion_pregunta25: @evaluacion.expresion_pregunta25, expresion_pregunta26: @evaluacion.expresion_pregunta26, expresion_pregunta27: @evaluacion.expresion_pregunta27, expresion_pregunta28: @evaluacion.expresion_pregunta28, expresion_pregunta29: @evaluacion.expresion_pregunta29, expresion_pregunta30: @evaluacion.expresion_pregunta30, expresion_pregunta31: @evaluacion.expresion_pregunta31, motivacion: @evaluacion.motivacion, motivacion_pregunta10: @evaluacion.motivacion_pregunta10, motivacion_pregunta1: @evaluacion.motivacion_pregunta1, motivacion_pregunta2: @evaluacion.motivacion_pregunta2, motivacion_pregunta3: @evaluacion.motivacion_pregunta3, motivacion_pregunta4: @evaluacion.motivacion_pregunta4, motivacion_pregunta5: @evaluacion.motivacion_pregunta5, motivacion_pregunta6: @evaluacion.motivacion_pregunta6, motivacion_pregunta7: @evaluacion.motivacion_pregunta7, motivacion_pregunta8: @evaluacion.motivacion_pregunta8, motivacion_pregunta9: @evaluacion.motivacion_pregunta9, representacion: @evaluacion.representacion, representacion_pregunta11: @evaluacion.representacion_pregunta11, representacion_pregunta12: @evaluacion.representacion_pregunta12, representacion_pregunta13: @evaluacion.representacion_pregunta13, representacion_pregunta14: @evaluacion.representacion_pregunta14, representacion_pregunta15: @evaluacion.representacion_pregunta15, representacion_pregunta16: @evaluacion.representacion_pregunta16, representacion_pregunta17: @evaluacion.representacion_pregunta17, representacion_pregunta18: @evaluacion.representacion_pregunta18, representacion_pregunta19: @evaluacion.representacion_pregunta19, representacion_pregunta20: @evaluacion.representacion_pregunta20, representacion_pregunta21: @evaluacion.representacion_pregunta21, representacion_pregunta22: @evaluacion.representacion_pregunta22, texto_libre: @evaluacion.texto_libre, user_id: @evaluacion.user_id }
    end

    assert_redirected_to evaluacion_path(assigns(:evaluacion))
  end

  test "should show evaluacion" do
    get :show, id: @evaluacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evaluacion
    assert_response :success
  end

  test "should update evaluacion" do
    patch :update, id: @evaluacion, evaluacion: { curso_id: @evaluacion.curso_id, expresion: @evaluacion.expresion, expresion_pregunta23: @evaluacion.expresion_pregunta23, expresion_pregunta24: @evaluacion.expresion_pregunta24, expresion_pregunta25: @evaluacion.expresion_pregunta25, expresion_pregunta26: @evaluacion.expresion_pregunta26, expresion_pregunta27: @evaluacion.expresion_pregunta27, expresion_pregunta28: @evaluacion.expresion_pregunta28, expresion_pregunta29: @evaluacion.expresion_pregunta29, expresion_pregunta30: @evaluacion.expresion_pregunta30, expresion_pregunta31: @evaluacion.expresion_pregunta31, motivacion: @evaluacion.motivacion, motivacion_pregunta10: @evaluacion.motivacion_pregunta10, motivacion_pregunta1: @evaluacion.motivacion_pregunta1, motivacion_pregunta2: @evaluacion.motivacion_pregunta2, motivacion_pregunta3: @evaluacion.motivacion_pregunta3, motivacion_pregunta4: @evaluacion.motivacion_pregunta4, motivacion_pregunta5: @evaluacion.motivacion_pregunta5, motivacion_pregunta6: @evaluacion.motivacion_pregunta6, motivacion_pregunta7: @evaluacion.motivacion_pregunta7, motivacion_pregunta8: @evaluacion.motivacion_pregunta8, motivacion_pregunta9: @evaluacion.motivacion_pregunta9, representacion: @evaluacion.representacion, representacion_pregunta11: @evaluacion.representacion_pregunta11, representacion_pregunta12: @evaluacion.representacion_pregunta12, representacion_pregunta13: @evaluacion.representacion_pregunta13, representacion_pregunta14: @evaluacion.representacion_pregunta14, representacion_pregunta15: @evaluacion.representacion_pregunta15, representacion_pregunta16: @evaluacion.representacion_pregunta16, representacion_pregunta17: @evaluacion.representacion_pregunta17, representacion_pregunta18: @evaluacion.representacion_pregunta18, representacion_pregunta19: @evaluacion.representacion_pregunta19, representacion_pregunta20: @evaluacion.representacion_pregunta20, representacion_pregunta21: @evaluacion.representacion_pregunta21, representacion_pregunta22: @evaluacion.representacion_pregunta22, texto_libre: @evaluacion.texto_libre, user_id: @evaluacion.user_id }
    assert_redirected_to evaluacion_path(assigns(:evaluacion))
  end

  test "should destroy evaluacion" do
    assert_difference('Evaluacion.count', -1) do
      delete :destroy, id: @evaluacion
    end

    assert_redirected_to evaluaciones_path
  end
end
