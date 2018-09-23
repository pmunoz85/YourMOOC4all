# -*- encoding : utf-8 -*-
class Mineria

	def crawler_web(id_del_proveedor)

		proveedor = Proveedor.find(id_del_proveedor)

		tag_apartado = proveedor.apartado
		tag_lista_cursos = proveedor.lista_cursos
		tag_nombre = proveedor.nombre_curso
		tag_universidad = proveedor.universidad
		tag_tematica = proveedor.tematica
		tag_informacion = proveedor.informacion
		tag_esfuerzo = proveedor.esfuerzo
		tag_pagina_siguiente = proveedor.pagina_siguiente

		sitio = proveedor.url #params["sitio"]

		doc = Nokogiri::HTML(open(sitio + tag_apartado))

		cursos = doc.css(tag_lista_cursos)

		mas_paginas = true
		pagina = 0
		while mas_paginas do
			puts "------------"			
			puts "------------"	
			puts cursos.count		
			puts "------------"			
			puts "------------"			
			puts "------------"			
			cursos.each do |curso|
				puts "=========="
				puts "=========="
				puts "=========="
				puts "=========="
				if sitio == "https://www.coursera.org" then
					v_identificador = curso['href']
				else
					v_identificador = curso.css('a')[0]['href']
				end
				#curso.css('a')[0]['href']
				#if Curso.find_by_identificador(curso.css(tag_id).text).nil? then
				if Curso.find_by_identificador(v_identificador).nil? then
					registro = Curso.new

					# URL DEL CURSO
					direccion_curso = sitio + v_identificador
					detalle_curso = Nokogiri::HTML(open(direccion_curso))

					# ID DEL CURSO
					#registro.identificador = curso.css(tag_id).text
					registro.identificador = v_identificador

					# DIRECCIÓN DE ANÁLISIS
					registro.url = sitio

					# NOMBRE DEL CURSO
#					registro.nombre = curso.css(tag_nombre).text
					if sitio == "https://www.coursera.org" then
						#registro.nombre = detalle_curso.css(tag_nombre).text
						if detalle_curso.css('.title').text.empty? then
							registro.nombre = detalle_curso.css('.s12n-headline').text
						else

							registro.nombre = detalle_curso.css('title').text
						end
					else
						registro.nombre = detalle_curso.css(tag_nombre)[0].text
					end

					# IMAGEN DEL CURSO
#					url_imagen = sitio + curso.css('img')[0]['src']

					if sitio == "https://iedra.uned.es" then
						url_imagen = sitio + detalle_curso.css('.hero>img')[0]['src']
					else
						url_imagen = detalle_curso.css("meta[property='og:image']")[0]['content']
					end

					unless url_imagen.index(/http/).nil? then
						#registro.imagen_from_url url_imagen #unless url_imagen.nil?
						registro.imagen_url = url_imagen
					end

					# PROVEEDOR
					registro.proveedor = proveedor
					
					# UNIVERSIDAD
					if sitio == "https://miriadax.net" then
						nombre_uni = detalle_curso.css(tag_universidad)[0]['title'].strip
					else
						if sitio == "https://www.coursera.org" then
						#nombre_uni = detalle_curso.css(tag_universidad).text.strip[0,254]
							if detalle_curso.css('.creator-names').text.sub(/Created by:/,'').empty? then
								nombre_uni = detalle_curso.css('p.partner-marketing-blurb').text.strip[0,254]
							else
								nombre_uni = detalle_curso.css('.creator-names').text.sub(/Created by:/,'')
							end
						else
							nombre_uni = detalle_curso.css(tag_universidad).text.strip
						end
					end
					id_uni = Universidad.find_by_nombre(nombre_uni)
					if id_uni.nil? then
						uni = Universidad.create(:nombre => nombre_uni)
						registro.universidad = uni
					else
						registro.universidad = id_uni
					end
					
					# TEMÁTICA
					if sitio == "https://www.coursera.org" then
						if detalle_curso.css('.target-audience-section').text.nil? then

							detalle_curso.css('.s12n-subheader').text
						else
							detalle_curso.css('.target-audience-section').text.sub(/Who is this class for:/,'')
						end
					else
						unless detalle_curso.css(tag_tematica)[0].nil? then
							registro.tematica = detalle_curso.css(tag_tematica)[0].text.gsub(/\t/,'').gsub(/\n/,'').gsub(/\r/,'')
						end
					end

					# INFORMACIÓN DEL CURSO
					registro.informacion = detalle_curso.css(tag_informacion).text # html 

					# ESFUERZO ESTIMADO
					esfuerzo = ''
					# Esta línea es para MiriadaX
					
					if sitio == "https://www.coursera.org" then
						if detalle_curso.css('.course-description').text.nil? then
							esfuerzo = detalle_curso.css('description')
						else
							detalle_curso.css('.course-description').text.sub(/About this course:/,'')	
						end
					else
						esfuerzo = detalle_curso.css(tag_esfuerzo)[0].text.gsub(/\t/,'').gsub(/\n/,'').gsub(/\r/,'')[0, 150]
					end

					# Esta línea es para UNED Abierta
					detalle_curso.css(tag_esfuerzo).each do |linea|
						if linea.text.index(/Esfuerzo estimado/)
							esfuerzo = linea.text.sub(/Esfuerzo estimado/,'')
						end
					end
					registro.esfuerzo_estimado = esfuerzo

					# CONOCIMIENTOS PREVIOS
					# TODO registro.conocimientos_previos

#				(1..100000000).each do 
#				end
					registro.save
				end
			end

			siguiente = doc.css(tag_pagina_siguiente)
			#if doc.css(tag_pagina_siguiente).empty? 
			if siguiente.empty? then
				mas_paginas = false

	# Este código es en exclusiva para Coursera
	pagina = pagina + 20
	siguiente = sitio + '/courses?_facet_changed_=true&primaryLanguages=es&start=' + pagina.to_s
	doc = Nokogiri::HTML(open(siguiente))
	cursos = doc.css('a.rc-OfferingCard')
	mas_paginas = true if cursos.count > 0
	# hasta aquí

			else
				siguiente = doc.css(tag_pagina_siguiente)[0]['href']

				doc = Nokogiri::HTML(open(siguiente))

				cursos = doc.css(tag_lista_cursos)
	
				pagina += 1
			end

		end

		#redirect_to controller: 'proveedores', action: 'index'
	end

#	handle_asynchronously :crawler_web


end

