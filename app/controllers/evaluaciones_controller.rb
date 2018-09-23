# -*- encoding : utf-8 -*-
class EvaluacionesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 

#  load_and_authorize_resource skip_load_resource only: [:create] 
  
  before_action :set_evaluacion, only: [:show, :edit, :update, :destroy]

#  layout 'administrador' if not current_user == nil and current_user.has_role? 'administrador'
  layout :evaluacion_layout
 
  def listado
    datos = []
    Evaluacion.all.each do |j| 
      datos << j.descripcion 
    end

    render :json => datos.to_json
  end

  def index
#    @evaluaciones = Evaluacion.all
    @evaluaciones = Evaluacion.paginate(:page => params[:page], :per_page => 20)
  end

  def show
#    @registros = @evaluacion.RELACIONADOS.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    if params[:user].nil? then
      usuario = current_user.id
    else
      usuario = params[:user]
    end
    @evaluacion = Evaluacion.new(:user_id => usuario, :curso_id => params[:curso])
  end

  def edit
  end

  def create
    @evaluacion = Evaluacion.new(evaluacion_params)

    if @evaluacion.save
#      redirect_to evaluaciones_url, notice: 'La evaluación fue creada correctamente.'
#      redirect_to home_index_url(:buscar => @evaluacion.curso.nombre), notice: 'La evaluación fue creada correctamente.'
      redirect_to @evaluacion.curso, notice: t('mio.create_evaluacion')
    else
      render action: 'new'
    end
  end

  def update
    if @evaluacion.update(evaluacion_params)
#      redirect_to @evaluacion, notice: 'La evaluación fue actualizada correctamente.'
#      redirect_to home_index_url(:buscar => @evaluacion.curso.nombre), notice: 'La evaluación fue actualizada correctamente.'
      redirect_to @evaluacion.curso, notice: t('mio.update_evaluacion')
    else
      render action: 'edit'
    end
  end

  def destroy
    nombre = @evaluacion.curso.nombre
    @evaluacion.destroy
#    redirect_to evaluaciones_url, notice: 'La evaluación fue borrada correctamente.'
    redirect_to home_index_url(:buscar => nombre), notice: t('mio.destroy_evaluacion')
  end

  private
    def evaluacion_layout
      if current_user.has_role? 'administrador' 
        return "administrador"
      else
        return "inicio"
      end
    end
 
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluacion
      @evaluacion = Evaluacion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def evaluacion_params
      #params.require(:evaluacion).permit(:user_id, :curso_id, :motivacion_pregunta1, :motivacion_pregunta2, :motivacion_pregunta3, :motivacion_pregunta4, :motivacion_pregunta5, :motivacion_pregunta6, :motivacion_pregunta7, :motivacion_pregunta8, :motivacion_pregunta9, :motivacion_pregunta10, :motivacion, :representacion_pregunta11, :representacion_pregunta12, :representacion_pregunta13, :representacion_pregunta14, :representacion_pregunta15, :representacion_pregunta16, :representacion_pregunta17, :representacion_pregunta18, :representacion_pregunta19, :representacion_pregunta20, :representacion_pregunta21, :representacion_pregunta22, :representacion, :expresion_pregunta23, :expresion_pregunta24, :expresion_pregunta25, :expresion_pregunta26, :expresion_pregunta27, :expresion_pregunta28, :expresion_pregunta29, :expresion_pregunta30, :expresion_pregunta31, :expresion, :texto_libre)
            
      params.require(:evaluacion).permit(:user_descripcion, :user_nombre, :user_name, :curso_descripcion, :curso_nombre, :curso_name, :user_id, :curso_id, :motivacion_pregunta1, :motivacion_pregunta2, :motivacion_pregunta3, :motivacion_pregunta4, :motivacion_pregunta5, :motivacion_pregunta6, :motivacion_pregunta7, :motivacion_pregunta8, :motivacion_pregunta9, :motivacion_pregunta10, :motivacion, :representacion_pregunta11, :representacion_pregunta12, :representacion_pregunta13, :representacion_pregunta14, :representacion_pregunta15, :representacion_pregunta16, :representacion_pregunta17, :representacion_pregunta18, :representacion_pregunta19, :representacion_pregunta20, :representacion_pregunta21, :representacion_pregunta22, :representacion, :expresion_pregunta23, :expresion_pregunta24, :expresion_pregunta25, :expresion_pregunta26, :expresion_pregunta27, :expresion_pregunta28, :expresion_pregunta29, :expresion_pregunta30, :expresion_pregunta31, :expresion, :texto_libre, :experiencia, :progreso)
    end
end

