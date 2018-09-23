require 'test_helper'

class CursosControllerTest < ActionController::TestCase
  setup do
    @curso = cursos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cursos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create curso" do
    assert_difference('Curso.count') do
      post :create, curso: { conocimientos_previos: @curso.conocimientos_previos, esfuerzo_estimado: @curso.esfuerzo_estimado, identificador: @curso.identificador, imagen: @curso.imagen, informacion: @curso.informacion, lenguaje_signos: @curso.lenguaje_signos, nombre: @curso.nombre, precio_auditado: @curso.precio_auditado, precio_credencial: @curso.precio_credencial, proveedor_id: @curso.proveedor_id, tematica: @curso.tematica, universidad_id: @curso.universidad_id, url: @curso.url }
    end

    assert_redirected_to curso_path(assigns(:curso))
  end

  test "should show curso" do
    get :show, id: @curso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @curso
    assert_response :success
  end

  test "should update curso" do
    patch :update, id: @curso, curso: { conocimientos_previos: @curso.conocimientos_previos, esfuerzo_estimado: @curso.esfuerzo_estimado, identificador: @curso.identificador, imagen: @curso.imagen, informacion: @curso.informacion, lenguaje_signos: @curso.lenguaje_signos, nombre: @curso.nombre, precio_auditado: @curso.precio_auditado, precio_credencial: @curso.precio_credencial, proveedor_id: @curso.proveedor_id, tematica: @curso.tematica, universidad_id: @curso.universidad_id, url: @curso.url }
    assert_redirected_to curso_path(assigns(:curso))
  end

  test "should destroy curso" do
    assert_difference('Curso.count', -1) do
      delete :destroy, id: @curso
    end

    assert_redirected_to cursos_path
  end
end
