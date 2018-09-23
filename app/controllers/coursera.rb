# -*- encoding : utf-8 -*-
class Coursera

	def crawler(nombre, sitio)

#		proveedor = Proveedor.find_by_nombre(nombre)

		tag_apartado = '/courses?_facet_changed_=true&primaryLanguages=es'
		tag_lista_cursos = 'a.rc-OfferingCard'
		tag_nombre = '.title'
		tag_imagen = 'img.offering-image'
		tag_universidad = '.creator-names' 
		tag_tematica = '.course-description'
		tag_informacion = '.content-inner' #'.rc-SectionWrapper' #'.rc-TogglableContent' #'.body-1-text' #'.target-audience-section'

		tag_destinatarios = '.target-audience-section'
		tag_tabla = '.basic-info-table'
		tag_inicio = '.rc-StartDateString' #startdate rc-StartDateString caption-text

		doc = Nokogiri::HTML(open(sitio + tag_apartado), nil, Encoding::UTF_8.to_s)

		cursos = doc.css(tag_lista_cursos)

		mas_paginas = true
		pagina = 0
		while mas_paginas do
			cursos.each do |curso|
				v_identificador = curso['href']

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
					if detalle_curso.css(tag_nombre).text.empty? then
						registro.nombre = detalle_curso.css('.s12n-headline').text
					else

						registro.nombre = detalle_curso.css(tag_nombre).text
					end

					# IMAGEN DEL CURSO
					url_imagen = curso.css(tag_imagen)[0]['src']
					url_imagen = url_imagen[0,url_imagen.index(/\?/)]
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
					if detalle_curso.css(tag_universidad).text.sub(/Created by:/,'').empty? then
						nombre_uni = detalle_curso.css('p.partner-marketing-blurb').text.strip[0,254]
					else
						nombre_uni = detalle_curso.css(tag_universidad).text.sub(/Created by:/,'')
					end
					id_uni = Universidad.find_by_nombre(nombre_uni)
					if id_uni.nil? then
						id_uni = Universidad.create(:nombre => nombre_uni)
					end
					registro.universidad = id_uni
					
					# TEMÁTICA  pendiente
					if detalle_curso.css(tag_tematica).text.nil? then
						registro.tematica = detalle_curso.css('.s12n-subheader') #.text
						tmp = ''
					else
						if detalle_curso.css(tag_tematica).length > 500
							registro.tematica = detalle_curso.css(tag_tematica) #[0,500] + '...' #.text
							registro.tematica = registro.tematica.gsub(/^\s+/,'')
							registro.tematica = registro.tematica.gsub(/<script[^>]*>(.*?)<\/script>/,'')
							registro.tematica = registro.tematica.gsub(/<(.*?)>/,'')
							tmp = registro.tematica[0,500]  #.text
							registro.tematica = tmp + '...' #.text
							tmp = tmp.text
						else
							tmp = detalle_curso.css(tag_tematica) #.text
							registro.tematica = tmp #.text
							registro.tematica = registro.tematica.gsub(/^\s+/,'')
							registro.tematica = registro.tematica.gsub(/<script[^>]*>(.*?)<\/script>/,'')
							registro.tematica = registro.tematica.gsub(/<(.*?)>/,'')
							tmp = tmp.text
						end
					end

					# INFORMACIÓN DEL CURSO
					#registro.informacion = detalle_curso.css(tag_informacion).text.gsub(registro.tematica,'') # html 
					registro.informacion = detalle_curso.css(tag_informacion) 
					registro.informacion = registro.informacion.gsub(/^\s+/,'')
					registro.informacion = registro.informacion.gsub(/<script[^>]*>(.*?)<\/script>/,'')
					registro.informacion = registro.informacion.gsub(/<(.*?)>/,'')
					registro.informacion = registro.informacion.gsub(tmp,'') 

					#Quitamos el 'About this course: '
					registro.tematica = registro.tematica.gsub('About this course: ','')

					# ESFUERZO ESTIMADO
					esfuerzo = ''
					# CONOCIMIENTOS PREVIOS
					requerimientos = ''
					# TIPOS DE ACTIVIDADES Y EVALUACION
					evaluacion = ''
					# OBJETIVOS DE APRENDIZAJE
					objetivos = ''
					detalle_curso.css(tag_tabla).css('tr').each do |linea|

						if linea.text.index(/Commitment/)
							esfuerzo = linea.text.gsub(/Commitment/,'')
						end

						if linea.text.index(/Hardware Req/)
							requerimientos = linea.text.gsub(/Hardware Req/,'')
						end

						if linea.text.index(/How To Pass/)
							evaluacion = linea.text.gsub(/How To Pass/,'')
						end

						if linea.text.index(/Level/)
							objetivos = linea.text.gsub(/Level/,'')
						end
					end
					registro.esfuerzo_estimado = esfuerzo
					registro.conocimientos_previos = requerimientos
					registro.evaluacion = evaluacion
					registro.objetivos = objetivos

					# DESTINATARIOS Y NIVEL
					registro.destinatarios = detalle_curso.css(tag_destinatarios).text

					# FECHA DE INICIO
					registro.inicio = detalle_curso.css(tag_inicio).text

					# PRECIO AUDITADO
					# PRECIO CREDITO
					precio_auditado = ''
					precio_credencial = ''
#					detalle_curso.css(tag_datos).each do |linea|
#						if linea.text.index(/Precio como oyente/)
#							precio_auditado = linea.text.sub(/Precio como oyente/,'').strip
#						end
#						if linea.text.index(/Precio de la credencial de superación del curso/)
#							precio_credencial = linea.text.sub(/Precio de la credencial de superación del curso/,'').strip
#						end
#					end
#					registro.precio_auditado = precio_auditado
#					registro.precio_credencial = precio_credencial

					registro.save
				end
			end

			pagina = pagina + 20
			siguiente = sitio + '/courses?_facet_changed_=true&primaryLanguages=es&start=' + pagina.to_s
			doc = Nokogiri::HTML(open(siguiente), nil, Encoding::UTF_8.to_s)
			cursos = doc.css(tag_lista_cursos)

			#mas_paginas = false if cursos.nil? 
			mas_paginas = false if cursos.count == 0

		end

		#redirect_to controller: 'proveedores', action: 'index'
	end

	handle_asynchronously :crawler
##	handle_asynchronously_without_delay :crawler_web


end

