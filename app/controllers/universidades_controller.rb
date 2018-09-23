# -*- encoding : utf-8 -*-
class UniversidadesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 
  
  before_action :set_universidad, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Universidad.all.each do |j| 
      datos << j.nombre 
    end

    render :plain => datos
  end


  def index
#    @universidades = Universidad.all
    @universidades = Universidad.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @cursos = @universidad.cursos.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @universidad = Universidad.new
  end

  def edit
  end

  def create
    @universidad = Universidad.new(universidad_params)

    if @universidad.save
      redirect_to universidades_url, notice: t('mio.create_universidad')
    else
      render action: 'new'
    end
  end

  def update
    if @universidad.update(universidad_params)
      redirect_to @universidad, notice: t('mio.update_universidad')
    else
      render action: 'edit'
    end
  end

  def destroy
    @universidad.destroy
    redirect_to universidades_url, notice: t('mio.destory_universidad')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_universidad
      @universidad = Universidad.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def universidad_params
      #params.require(:universidad).permit(:nombre)

      params.require(:universidad).permit(:nombre)
    end
end

