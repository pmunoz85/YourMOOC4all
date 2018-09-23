class HomeController < ApplicationController

	def index
		if current_user.nil? then

			unless params[:buscar].nil?
				buscar_cursos 
			else
				@cursos = Curso.all.paginate(:per_page => 4, :page => params[:page])
			end

		else
			if current_user.has_role? 'administrador'
				redirect_to controller: 'administrador', action: 'index', buscar: params[:buscar], orden_busqueda: params[:orden_busqueda], campo_busqueda: params[:campo_busqueda]
			else
				redirect_to controller: 'inicio', action: 'index', buscar: params[:buscar], orden_busqueda: params[:orden_busqueda], campo_busqueda: params[:campo_busqueda]
			end
		end
	end
  
end
