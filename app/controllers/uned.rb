# -*- encoding : utf-8 -*-
class Uned < Mineria
 
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

		#sitio = params["sitio"]

		tag_apartado = '/'
		tag_lista_cursos = '.course'
		tag_nombre = '.course-name'
		tag_universidad = '.course-organization' 
		tag_tematica = 'p'
		tag_informacion = '.details'
		tag_esfuerzo = '.effort'
		tag_inicio = '.start-date'
		tag_datos = '.important-dates-item'
#		tag_pagina_siguiente = 'nada'

		doc = Nokogiri::HTML(open(sitio + tag_apartado), nil, Encoding::UTF_8.to_s)

		cursos = doc.css(tag_lista_cursos)

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
				registro.nombre = detalle_curso.css(tag_nombre).text

				# IMAGEN DEL CURSO
				url_imagen = sitio + curso.css('img')[0]['src']

				unless url_imagen.index(/http/).nil? then
					registro.imagen_url = url_imagen
				end

				# PROVEEDOR
				proveedor = Proveedor.find_by_nombre(nombre)
				if proveedor.nil? then
					proveedor = Proveedor.create(:nombre => nombre, :url => sitio)
				end
				registro.proveedor = proveedor
				
				# UNIVERSIDAD
				nombre_uni = curso.css(tag_universidad).text.strip
				id_uni = Universidad.find_by_nombre(nombre_uni)
				if id_uni.nil? then
					uni = Universidad.create(:nombre => nombre_uni)
					registro.universidad = uni
				else
					registro.universidad = id_uni
				end
				
				# TEMÁTICA
				if detalle_curso.css(tag_tematica)[0].text.gsub(/\s+/,'') == " " then
					tmp = detalle_curso.css(tag_informacion).text.gsub(/^\s+/,'')[0,500]
					registro.tematica = tmp + ' ... '
				else
					tmp = detalle_curso.css(tag_tematica)[0].text.gsub(/^\s+/,'')
					registro.tematica = tmp
				end

				# INFORMACIÓN DEL CURSO
				registro.informacion = detalle_curso.css(tag_informacion).text.gsub(/^\s+/,'') # html 
				registro.informacion = registro.informacion.gsub(tmp,'') # html 

				# OBJETIVOS DE APRENDIZAJE
				registro.objetivos = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Objetivos', cadenas)

				# CONOCIMIENTOS PREVIOS
				registro.conocimientos_previos = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Requisitos recomendados', cadenas)

				# DESTINATARIOS Y NIVEL
				registro.destinatarios = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Público objetivo', cadenas)

				# TIPOS DE ACTIVIDADES Y EVALUACION
				registro.evaluacion = busca_texto_informacion(detalle_curso.css(tag_informacion), 'Actividades y Tareas', cadenas)
				
				# ESFUERZO ESTIMADO
				registro.esfuerzo_estimado = detalle_curso.css(tag_esfuerzo).text 

				# FECHA DE INICIO
				registro.inicio = detalle_curso.css(tag_inicio).text

				# PRECIO AUDITADO
				# PRECIO CREDITO
				precio_auditado = ''
				precio_credencial = ''
				detalle_curso.css(tag_datos).each do |linea|
					if linea.text.index(/Precio como oyente/)
						precio_auditado = linea.text.sub(/Precio como oyente/,'').strip
					end
					if linea.text.index(/Precio de la credencial de superación del curso/)
						precio_credencial = linea.text.sub(/Precio de la credencial de superación del curso/,'').strip
					end
				end
				registro.precio_auditado = precio_auditado
				registro.precio_credencial = precio_credencial

				registro.save
			end

		end

		#redirect_to controller: 'proveedores', action: 'index'
	end

	handle_asynchronously :crawler
#	handle_asynchronously_without_delay :crawler_web


end

