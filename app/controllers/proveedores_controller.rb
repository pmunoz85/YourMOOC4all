# -*- encoding : utf-8 -*-
class ProveedoresController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource #skip_load_resource only: [:create] 
  skip_load_resource only: [:create] 
  
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]

  layout 'administrador'

  def listado
    datos = []
    Proveedor.all.each do |j| 
      datos << j.nombre 
    end

    render :json => datos.to_json
  end

  def index
#    @proveedores = Proveedor.all
    @proveedores = Proveedor.paginate(:page => params[:page], :per_page => 20)

		mineria_datos unless params["sitio"].nil?
  end

  def show
    @cursos = @proveedor.cursos.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @proveedor = Proveedor.new
  end

  def edit
  end

  def create
    @proveedor = Proveedor.new(proveedor_params)

    if @proveedor.save
      redirect_to proveedores_url, notice: t('mio.create_proveedor')
    else
      render action: 'new'
    end
  end

  def update
    if @proveedor.update(proveedor_params)
      redirect_to @proveedor, notice: t('mio.update_proveedor')
    else
      render action: 'edit'
    end
  end

  def destroy
    @proveedor.destroy
    redirect_to proveedores_url, notice: t('mio.destroy_proveedor')
  end

	def mineria_datos
		m = Mineria.new
		m.crawler_web(params["id"])

		flash[:danger] = t('mio.comienza_adquirir') + params["sitio"]
	end

private
	# Use callbacks to share common setup or constraints between actions.
	def set_proveedor
		@proveedor = Proveedor.find(params[:id])
	end

	# Only allow a trusted parameter "white list" through.
	def proveedor_params
		#params.require(:proveedor).permit(:nombre, :url)

		params.require(:proveedor).permit(:nombre, :url, :apartado, 
			:lista_cursos, :nombre_curso, :universidad, 
			:tematica, :informacion, :esfuerzo, :pagina_siguiente)
		#params.require(:proveedor).permit!
	end

end

