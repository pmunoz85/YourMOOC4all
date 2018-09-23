class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#	before_filter :authenticate_user!

	before_action :set_locale
	before_action :set_i18n_locale_from_params

	def set_locale
	  I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
	end

	def extract_locale_from_accept_language_header
	  request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
	  locale if ['es', 'en'].include? locale.to_s
	end

	def buscar_cursos(ver_ocultos = false)
		session[:campo_busqueda] = params[:campo_busqueda]
		session[:orden_busqueda] = params[:orden_busqueda]

		orden = 'cursos.nombre'
		orden = 'cursos.nombre' if params[:orden_busqueda] == t("mio.orden_busqueda_titulo") #'Título del curso'
		orden = 'universidades.nombre' if params[:orden_busqueda] == t("mio.orden_busqueda_instituciones") #'Instituciones'
		orden = 'proveedores.nombre' if params[:orden_busqueda] == t("mio.orden_busqueda_plataformas") #'Plataformas'
		orden = 'puntuacion' if params[:orden_busqueda] == t("mio.orden_busqueda_puntuacion") #'Puntuación obtenida'

		if params[:buscar].nil? or params[:buscar].empty?
			if orden == 'puntuacion' then
				todos_cursos = Curso.joins(
					'left join universidades on universidades.id = cursos.universidad_id
					left join proveedores on proveedores.id = cursos.proveedor_id
					').sort_by(&:puntuacion) #.paginate(:per_page => 4, :page => params[:page])

				cursos_array = []

				todos_cursos.each do |t| 
					cursos_array << t.id
				end

				cursos_literal = cursos_array.join(', ')

				if 'development' == ENV['RAILS_ENV'] then
					@cursos = Curso.order("field (id, #{cursos_literal})").paginate(:per_page => 4, :page => params[:page])
				else
					@cursos = Curso.order_by_ids(cursos_array).paginate(:per_page => 4, :page => params[:page])
				end
			else
				@cursos = Curso.joins(
				'left join universidades on universidades.id = cursos.universidad_id
				left join proveedores on proveedores.id = cursos.proveedor_id
				').order(orden).paginate(:per_page => 4, :page => params[:page])
			end
#			@cursos = Curso.order(orden).paginate(:page => params[:page], :per_page => 20)
			return
		end

		@resaltado = []
		filtro = []
		contenido = []
		@buscar = params[:buscar] 
		@buscar_cursos = @buscar.split(' ').join('|')

		palabras_juntas = @buscar.scan( /<([^>]*)>/)

		palabras_sueltas = @buscar.gsub( /<([^>]*)>/,'').split(' ')

		palabras_juntas.each do |palabra|
			contenido << palabra.to_s.gsub(/[\"\[\]]/,'')
		end
		
		palabras_sueltas.each do |palabra|
			contenido << palabra.to_s
		end

		linea = []
		linea2 = []

#lenguaje_signos
#precio_auditado
#precio_credencial

		if params[:campo_busqueda] == t("mio.campo_busqueda_todos") then  #'Todos' then
			contenido.each do |bus|
				if 'development' == ENV['RAILS_ENV'] then
					linea << "( 
							#{if not ver_ocultos then '(oculto IS NULL OR oculto IS FALSE) and ' end} 
							(upper(cursos.identificador) like upper(?) 
							or upper(cursos.nombre) like upper(?) 
							or upper(proveedores.nombre) like upper(?)
							or upper(universidades.nombre) like upper(?)
							or upper(cursos.tematica) like upper(?) 
							or upper(cursos.informacion) like upper(?) 
							or upper(cursos.conocimientos_previos) like upper(?) 
							or upper(cursos.esfuerzo_estimado) like upper(?) 
							or upper(cursos.objetivos) like upper(?) 
							or upper(cursos.destinatarios) like upper(?) 
							or upper(cursos.evaluacion) like upper(?) 
							or upper(cursos.inicio) like upper(?) ) )"
				else
					linea << "( 
							#{if not ver_ocultos then '(oculto IS NULL OR oculto IS FALSE) and ' end} 
							(translate(upper(cursos.identificador),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.nombre),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(proveedores.nombre),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU')
							or translate(upper(universidades.nombre),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU')
							or translate(upper(cursos.tematica),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.informacion),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.conocimientos_previos),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.esfuerzo_estimado),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.objetivos),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.destinatarios),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.evaluacion),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') 
							or translate(upper(cursos.inicio),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') ) )"
				end

				(1..12).each do
					linea2 << "%#{bus}%"
				end

				@resaltado << bus 
			end
		else
			if not ver_ocultos then 
				oculto = '(oculto IS NULL OR oculto IS FALSE) and ' 
			else
				oculto = ''
			end

			case params[:campo_busqueda]
			when t("mio.campo_busqueda_titulo") # "Título del curso"
				nombre_campo = 'cursos.nombre'
			when t("mio.campo_busqueda_tematica") # "Temática" 
				nombre_campo = 'cursos.tematica'
			when t("mio.campo_busqueda_informacion") # "Información"
				nombre_campo = 'cursos.informacion'
			else
				nombre_campo = 'cursos.nombre'
			end	


			contenido.each do |bus|
				if 'development' == ENV['RAILS_ENV'] then
					linea << "( #{oculto}	(upper(#{nombre_campo}) like upper(?) ) )"
				else
					linea << "( #{oculto}	(translate(upper(#{nombre_campo}),'ÁÉÍÓÚ','AEIOU') like translate(upper(?),'ÁÉÍÓÚ','AEIOU') ) )"
				end

				linea2 << "%#{bus}%"

				@resaltado << bus 
			end

		end

		filtro << linea.join(' and ') 
		linea2.each do |l|
			filtro << l
		end
		filtro.join(', ')

		if orden == 'puntuacion' then
			todos_cursos = Curso.joins(
				'left join universidades on universidades.id = cursos.universidad_id
				left join proveedores on proveedores.id = cursos.proveedor_id
				').where(filtro).sort_by(&:puntuacion) #.paginate(:per_page => 4, :page => params[:page])

			cursos_array = []

			todos_cursos.each do |t| 
				cursos_array << t.id
			end

			cursos_literal = cursos_array.join(', ')

			if cursos_literal.empty? then
				@cursos = Curso.where("1=0").paginate(:per_page => 4, :page => params[:page])
			else	
				if 'development' == ENV['RAILS_ENV'] then
					@cursos = Curso.where("id in (#{cursos_literal})").order("field (id, #{cursos_literal})").paginate(:per_page => 4, :page => params[:page])
				else
					@cursos = Curso.where("id in (#{cursos_literal})").order_by_ids(cursos_array).paginate(:per_page => 4, :page => params[:page])
				end
			end
		else
			@cursos = Curso.joins(
			'left join universidades on universidades.id = cursos.universidad_id
			left join proveedores on proveedores.id = cursos.proveedor_id
			').where(filtro).order(orden).paginate(:per_page => 4, :page => params[:page])
		end

#		ids = Array.new
#		e.each do |a|
#			ids << "#{a.id}"
#		end
#		ids = ids.join(',')


#		if ids.empty?
#			filtro = "false"
#		else
#			filtro = 'id in (' + ids + ')'
#		end

#		@expedientes = Expediente.where(filtro).order('expedientes.numero desc').paginate(:per_page => 20, :page => params[:page])

		@resaltado = anadir_acentos(@resaltado)
	end

	rescue_from CanCan::AccessDenied do |exception|
  		redirect_to root_url, :alert => exception.message
	end

	def anadir_acentos(resaltado)
		return "" if resaltado.nil? 

		#resaltado = resaltado.join(' ') if resaltado.class == Array 
		r = []

		resaltado.each do |i|
			i = i.gsub(/[ñÑ]/,'[ñÑ]')
			i = i.gsub(/[aáAÁ]/,'[aáAÁ]')
			i = i.gsub(/[eéEÉ]/,'[eéEÉ]')
			i = i.gsub(/[iíIÍ]/,'[iíIÍ]')
			i = i.gsub(/[oóOÓ]/,'[oóOÓ]')
			i = i.gsub(/[uúUÚ]/,'[uúUÚ]')
			r << i 
		end

		return r
	end

protected

	def autorizar_vista!(rol_necesario)
#
#		rol_necesario = ''
#		rol_necesario = 'administrador' if controller_name == 'Administrador'
#		rol_necesario = 'usuario' if controller_name == 'Inicio'
		
#		unless current_user.nil? then
#			if current_user.has_role? 'administrador'
#				puts "****************   Es el administrador "
#				redirect_to controller: 'administrador', action: 'index'
#			else
#				puts "****************   Es un usuario "
#				redirect_to controller: 'inicio', action: 'index'
#			end
		if current_user.present? then
			unless current_user.has_role? rol_necesario or current_user.has_role? 'administrador'
				flash[:danger] = I18n.t("mio.autorizacion")
				redirect_to root_path
			end
		else
			flash[:danger] = t("mio.autorizacion")
			redirect_to root_path
		end
	end

private

  def set_i18n_locale_from_params
    if params[:locale]

      if I18n.available_locales.map(&:to_s).include?(params[:locale])

        I18n.locale = params[:locale]

      else

        flash.now[:notice] = "#{params[:locale]} translation not available"

        logger.error flash.now[:notice]

      end
    end
	end

	def default_url_options(options = {})
	  {locale: I18n.locale}
	end
end


