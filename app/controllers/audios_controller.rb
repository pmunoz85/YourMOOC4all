# -*- encoding : utf-8 -*-
class AudiosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 

  before_action :set_audio, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Audio.all.each do |j| 
      datos << j.descripcion 
    end

    render :json => datos.to_json
  end


  def index
#    @audios = Audio.all
    @audios = Audio.paginate(:page => params[:page], :per_page => 20)
  end

  def show
#    @registros = @audio.RELACIONADOS.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @audio = Audio.new(:curso_id => params['curso_id'])
  end

  def edit
  end

  def create
    @audio = Audio.new(audio_params)

    if @audio.save
#      redirect_to audios_url, notice: 'Audio fue creado correctamente.'
      redirect_to @audio.curso, notice: t('mio.create_audio')
    else
      render action: 'new'
    end
  end

  def update
    if @audio.update(audio_params)
      redirect_to @audio.curso, notice: t('mio.update_audio')
    else
      render action: 'edit'
    end
  end

  def destroy
    @audio.destroy
    redirect_to audios_url, notice: t('mio.destroy_audio')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def audio_params
      params.require(:audio).permit(:curso_id, :idioma_id)
            
      #params.require(:audio).permit(:curso_descripcion, :curso_nombre, :curso_name, :idioma_descripcion, :idioma_nombre, :idioma_name, :curso_id, :idioma_id)
    end
end

