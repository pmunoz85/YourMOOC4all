class AdministradorController < ApplicationController
	before_filter :authenticate_user!

	before_filter {autorizar_vista!('administrador')}
	
	def index

		grupo = Evaluacion.select('proveedores.id, proveedores.nombre, count(*) as cantidad').joins(
				'left join cursos on cursos.id = evaluaciones.curso_id
				left join proveedores on proveedores.id = cursos.proveedor_id
				').group('proveedores.id, proveedores.nombre')

		u = 0
		c = 0
		e = 0
		m = 0

		grupo.each do |v|
			case v.nombre 
			when 'UNED Abierta'
				u = v.cantidad
			when 'MiriadaX'
				m = v.cantidad
			when 'Coursera'
				c = v.cantidad
			when 'edX'
				e = v.cantidad
			end
			
#			datos.push("Plataforma: #{v.nombre}" => v.cantidad)

		end 

		@datos_grafico1 = { 
							'UNED Abierta' => u, 
							'Miriadax' => m,
							'Coursera' => c,
							'edX' => e
							}

		unless params[:sitio].nil?
			if params[:sitio] == 'Todo' then
				w = Uned.new
				w.crawler('UNED Abierta', 'https://iedra.uned.es')

				w = Miriadax.new 
				w.crawler('MiriadaX', 'https://miriadax.net')

				w = Coursera.new  
				w.crawler('Coursera', 'https://www.coursera.org')

				w = Edx.new 	
				w.crawler('edX', 'https://www.edx.org')

				flash[:danger] = t('mio.comienza_adquirir_todo')
			else
				w = Uned.new if params[:nombre] == 'UNED Abierta'
				w = Miriadax.new if params[:nombre] == 'MiriadaX'
				w = Coursera.new if params[:nombre] == 'Coursera'
				w = Edx.new if params[:nombre] == 'edX'
	
				w.crawler(params[:nombre], params[:sitio])

				flash[:danger] = t('mio.comienza_adquirir') + params["sitio"]
			end

		end

		if params[:buscar]
			buscar_cursos(true)
		end
	end


end
