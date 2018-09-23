# -*- encoding : utf-8 -*-
class IdiomasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 
  
  before_action :set_idioma, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Idioma.all.each do |j| 
      datos << j.descripcion 
    end

    render :json => datos.to_json
  end


  def index
#    @idiomas = Idioma.all
    @idiomas = Idioma.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @subtitulos = @idioma.subtitulos.paginate(:page => params[:page], :per_page => 20)

    @audios = @idioma.audios.paginate(:page => params[:page], :per_page => 20)

    @transcripciones = @idioma.transcripciones.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @idioma = Idioma.new
  end

  def edit
  end

  def create
    @idioma = Idioma.new(idioma_params)

    if @idioma.save
      redirect_to idiomas_url, notice: t('mio.create_idioma')
    else
      render action: 'new'
    end
  end

  def update
    if @idioma.update(idioma_params)
      redirect_to @idioma, notice: t('mio.update_idioma')
    else
      render action: 'edit'
    end
  end

  def destroy
    @idioma.destroy
    redirect_to idiomas_url, notice: t('mio.destroy_idioma')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idioma
      @idioma = Idioma.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def idioma_params
      #params.require(:idioma).permit(:descripcion)

      params.require(:idioma).permit(:descripcion)
    end
end

