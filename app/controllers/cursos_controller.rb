# -*- encoding : utf-8 -*-
class CursosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  load_and_authorize_resource :except => [:show] #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 
  
  before_action :set_curso, only: [:show, :edit, :update, :destroy]

#  layout 'administrador'
  layout :evaluacion_layout

  def listado
    datos = []
    Curso.all.each do |j| 
      datos << j.nombre 
    end

    render :json => datos.to_json
  end

  def index
    @cursos = Curso.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @evaluaciones = @curso.evaluaciones.order('created_at desc').paginate(:page => params[:page], :per_page => 20)

    @subtitulos = @curso.subtitulos.paginate(:page => params[:page], :per_page => 20)

    @audios = @curso.audios.paginate(:page => params[:page], :per_page => 20)

    @transcripciones = @curso.transcripciones.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @curso = Curso.new
    @listado_cursos = Curso.all.collect {|p| [ p.nombre, p.id ] }
  end

  def edit
    listado_cursos_inteligente
  end

  def create
    @curso = Curso.new(curso_params)

    if @curso.save
      redirect_to cursos_url, notice: t('mio.create_curso')
    else
      render action: 'new'
    end
  end

  def update

    llave = true 

    unless params[:curso][:edicion_anterior_id].nil? or params[:curso][:edicion_anterior_id].empty?

      tmp = Curso.find(params[:curso][:edicion_anterior_id])

      while not tmp.nil?
        if tmp.id == @curso.id then
          tmp = nil
          llave = false
        end

        if llave
          if tmp.edicion_anterior_id.nil? then
            tmp = nil
          else
            tmp = Curso.find(tmp.edicion_anterior_id)
          end
        end
      end
    end

    if llave and @curso.update(curso_params)
#    if @curso.update(curso_params)
      redirect_to @curso, notice: t('mio.update_curso')
    else
      listado_cursos_inteligente
      flash[:error] = t('mio.update_curso_error')
      render action: 'edit'
    end
  end

  def destroy
    @curso.destroy
    redirect_to cursos_url, notice: t('mio.destroy_curso')
  end

  private
    def evaluacion_layout
      return "application" if current_user.nil?

      if current_user.has_role? 'administrador' 
        return "administrador"
      else
        return "inicio"
      end
    end
 
    def listado_cursos_inteligente
      require 'fuzzystringmatch'
      jarow = FuzzyStringMatch::JaroWinkler.create( :native )
      @listado_cursos = []

      Curso.all.each do |c|
        unless @curso.nombre == c.nombre then
          if jarow.getDistance(@curso.nombre, c.nombre) > 0.75 then
            @listado_cursos << [ c.nombre, c.id ]
          end
        end       
      end

#      @listado_cursos = Curso.order('nombre').all.collect {|p| [ p.nombre, p.id ] }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_curso
      @curso = Curso.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curso_params
      #params.require(:curso).permit(:identificador, :url, :nombre, :imagen, :proveedor_id, :universidad_id, :tematica, :informacion, :conocimientos_previos, :esfuerzo_estimado, :lenguaje_signos, :precio_auditado, :precio_credencial)
            
      params.require(:curso).permit(
            :identificador, 
            :url, 
            :nombre, 
            :imagen, 
            :proveedor_id, 
            :universidad_id, 
            :tematica, 
            :informacion, 
            :conocimientos_previos, 
            :esfuerzo_estimado, 
            :lenguaje_signos, 
            :precio_auditado, 
            :precio_credencial, 
            :objetivos, 
            :destinatarios, 
            :evaluacion, 
            :inicio, 
            :oculto,
            :edicion_anterior_id,
            :edicion_anterior_nombre)
    end
end

