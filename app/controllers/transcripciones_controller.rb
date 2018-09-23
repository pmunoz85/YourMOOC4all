# -*- encoding : utf-8 -*-
class TranscripcionesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 
  
  before_action :set_transcripcion, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Transcripcion.all.each do |j| 
      datos << j.descripcion 
    end

    render :json => datos.to_json
  end


  def index
#    @transcripciones = Transcripcion.all
    @transcripciones = Transcripcion.paginate(:page => params[:page], :per_page => 20)
  end

  def show
#    @registros = @transcripcion.RELACIONADOS.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @transcripcion = Transcripcion.new(:curso_id => params['curso_id'])
  end

  def edit
  end

  def create
    @transcripcion = Transcripcion.new(transcripcion_params)

    if @transcripcion.save
      redirect_to @transcripcion.curso, notice: t('mio.create_transcripcion')
    else
      render action: 'new'
    end
  end

  def update
    if @transcripcion.update(transcripcion_params)
      redirect_to @transcripcion.curso, notice: t('mio.update_transcripcion')
      render action: 'edit'
    end
  end

  def destroy
    @transcripcion.destroy
    redirect_to transcripciones_url, notice: t('mio.destroy_transcripcion')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transcripcion
      @transcripcion = Transcripcion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transcripcion_params
      #params.require(:transcripcion).permit(:curso_id, :idioma_id)
            
      params.require(:transcripcion).permit(:curso_descripcion, :curso_nombre, :curso_name, :idioma_descripcion, :idioma_nombre, :idioma_name, :curso_id, :idioma_id)
    end
end

