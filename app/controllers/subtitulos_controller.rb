# -*- encoding : utf-8 -*-
class SubtitulosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 

  before_action :set_subtitulo, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Subtitulo.all.each do |j| 
      datos << j.descripcion 
    end

    render :json => datos.to_json
  end


  def index
#    @subtitulos = Subtitulo.all
    @subtitulos = Subtitulo.paginate(:page => params[:page], :per_page => 20)
  end

  def show
#    @registros = @subtitulo.RELACIONADOS.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @subtitulo = Subtitulo.new(:curso_id => params['curso_id'])
  end

  def edit
  end

  def create
    @subtitulo = Subtitulo.new(subtitulo_params)

    if @subtitulo.save
#      redirect_to subtitulos_url, notice: 'Subtitulo fue creado correctamente.'
      redirect_to @subtitulo.curso, notice: t('mio.create_subtitulo')
    else
      render action: 'new'
    end
  end

  def update
    if @subtitulo.update(subtitulo_params)
      redirect_to @subtitulo.curso, notice: t('mio.update_subtitulo')
    else
      render action: 'edit'
    end
  end

  def destroy
    @subtitulo.destroy
    redirect_to subtitulos_url, notice: t('mio.destroy_subtitulo')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subtitulo
      @subtitulo = Subtitulo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subtitulo_params
      #params.require(:subtitulo).permit(:curso_id, :idioma_id)
            
      params.require(:subtitulo).permit(:curso_descripcion, :curso_nombre, :curso_name, :idioma_descripcion, :idioma_nombre, :idioma_name, :curso_id, :idioma_id)
    end
end

