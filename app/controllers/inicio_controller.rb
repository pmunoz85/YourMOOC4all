class InicioController < ApplicationController
  before_filter :authenticate_user!
	before_filter {autorizar_vista!('usuario')}

  def index
		if params[:buscar]
			buscar_cursos
		else
			unless params[:interesado].nil?

				if params[:megusta] == '1' 
					u = User.find(current_user.id)
					unless u.cursos.include?(Curso.find(params[:interesado].to_i))
						u.cursos << Curso.find(params[:interesado])
						u.save
					end
				else
					u = User.find(current_user.id)
					if u.cursos.include?(Curso.find(params[:interesado].to_i))
						u.cursos.delete(params[:interesado])
						u.save
					end
				end
			end

			@cursos = current_user.cursos.paginate(:per_page => 20, :page => params[:page])

			@cursos = Curso.all.paginate(:per_page => 4, :page => params[:page]) if @cursos.empty?

		end
  end

end
