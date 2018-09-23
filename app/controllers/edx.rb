# -*- encoding : utf-8 -*-
class Edx < Mineria

	def crawler(nombre, sitio)
		cadenas = [ 'Objetivos',
				    'Temario',
				    'Requisitos recomendados',
				    'Equipo docente',
				    'Público objetivo',
				    'Actividades y Tareas',
					'Calendario del curso',
					'Introducción',
					'Tipos de Actividades y Tareas',
					'Accesibilidad',
					'Patrocinadores',
					'Agradecimientos',
					'Redes sociales',
					'Material']

#		proveedor = Proveedor.find_by_nombre(nombre)

#https://www.edx.org/es/course?course=all

		tag_apartado = '/es/course?course=all'
		tag_lista_cursos = '.course-card'
		tag_nombre = 'title'
		tag_universidad = '.label'
		tag_tematica = '.course-description'
		tag_informacion = '.course-description'
		tag_esfuerzo = "li[data-field='effort]'"
		tag_pagina_siguiente = 'a.next'

		tag_inicio = '.course-start-info' 
		tag_objetivos = '.course-info-list'
		tag_requisitos = 'div>h2.course-info-heading'

		doc = Nokogiri::HTML(open(sitio + tag_apartado), nil, Encoding::UTF_8.to_s)

		cursos = doc.css(tag_lista_cursos)

		mas_paginas = true
		pagina = 0
		while mas_paginas do
			cursos.each do |curso|

				v_identificador = curso.css('a')[0]['href']

				if Curso.find_by_identificador(v_identificador).nil? then
					registro = Curso.new

					# URL DEL CURSO
					direccion_curso = sitio + v_identificador
					detalle_curso = Nokogiri::HTML(open(direccion_curso), nil, Encoding::UTF_8.to_s)

					# ID DEL CURSO
					registro.identificador = v_identificador

					# DIRECCIÓN DE ANÁLISIS
					registro.url = sitio

					# NOMBRE DEL CURSO
					registro.nombre = detalle_curso.css(tag_nombre)[0].text

					# IMAGEN DEL CURSO
					url_imagen = curso.css('img')[0]['src']
					unless url_imagen.index(/http/).nil? then
						registro.imagen_url = url_imagen
					else
						registro.imagen_url = detalle_curso.css("meta[property='og:image']")[0]['content']
						#registro.imagen_url = detalle_curso.css(".ytp-cued-thumbnail-overlay-image")['content']
					end

					# PROVEEDOR
					proveedor = Proveedor.find_by_nombre(nombre)
					if proveedor.nil? then
						proveedor = Proveedor.create(:nombre => nombre, :url => sitio)
					end
					registro.proveedor = proveedor
					
					# UNIVERSIDAD
					nombre_uni = curso.css(tag_universidad).text
					id_uni = Universidad.find_by_nombre(nombre_uni)
					if id_uni.nil? then
						uni = Universidad.create(:nombre => nombre_uni)
						registro.universidad = uni
					else
						registro.universidad = id_uni
					end
					
					# TEMÁTICA
					unless detalle_curso.css(tag_tematica)[0].nil? then
						registro.tematica = detalle_curso.css(tag_tematica) #[0].text.gsub(/^\s+/,'').gsub(/\t\t/,'').gsub(/\n\n/,'').gsub(/\r\r/,'').gsub(/\ \ /,'').gsub(/\r\n\r\n/,'')
					end

					# INFORMACIÓN DEL CURSO
					registro.informacion = detalle_curso.css(tag_informacion) #.text #.gsub(/\t\t/,'') # html 

					# OBJETIVOS DE APRENDIZAJE
					registro.objetivos = detalle_curso.css(tag_objetivos)

					# CONOCIMIENTOS PREVIOS
					registro.conocimientos_previos = detalle_curso.css(tag_requisitos).text

					# DESTINATARIOS Y NIVEL
#					registro.destinatarios = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Público objetivo', cadenas)

					# TIPOS DE ACTIVIDADES Y EVALUACION
#					registro.evaluacion = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Actividades y Tareas', cadenas)
					
					# ESFUERZO ESTIMADO
#					registro.esfuerzo_estimado = detalle_curso.css(tag_esfuerzo).text

					# FECHA DE INICIO
					registro.inicio = curso.css(tag_inicio)

					# PRECIO AUDITADO
#					registro.precio_auditado = precio_auditado

					# PRECIO CREDITO
#					registro.precio_credencial = precio_credencial

					registro.save
				end
			end

			siguiente = doc.css(tag_pagina_siguiente)
			if siguiente.empty? then
				mas_paginas = false
			else
				siguiente = doc.css(tag_pagina_siguiente)[0]['href']

				doc = Nokogiri::HTML(open(siguiente), nil, Encoding::UTF_8.to_s)

				cursos = doc.css(tag_lista_cursos)
	
				pagina += 1
			end
		end

		#redirect_to controller: 'proveedores', action: 'index'
	end

#	handle_asynchronously :crawler
##	handle_asynchronously_without_delay :crawler_web

end

