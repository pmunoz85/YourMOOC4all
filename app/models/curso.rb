class Curso < ActiveRecord::Base
	has_and_belongs_to_many :users
  
  has_many :evaluaciones

  has_many :subtitulos

  has_many :audios

  has_many :transcripciones

	belongs_to :proveedor

	belongs_to :universidad

#	validates_uniqueness_of :edicion_anterior_id

  has_attached_file :imagen

	validates_attachment_content_type :imagen, :content_type => [
							'image/jpg',
							'image/jpeg',
							'image/pjpeg',
							'image/png',
							'image/x-png',
							'image/gif',
							'application/binary',
							'application/pdf',
							'application/x-pdf',
							'application/x-download', 
							'application/msword',
							'applicationvnd.ms-word',
							'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
							'application/msexcel',
							'application/vnd.ms-excel',
							'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
							'application/mspowerpoint',
							'application/vnd.ms-powerpoint',
							'application/vnd.openxmlformats-officedocument.presentationml.presentation',
							'text/plain',
							'application/rtf']

	def self.order_by_ids(ids)
	  order_by = ["CASE"]
	  ids.each_with_index do |id, index|
	    order_by << "WHEN id='#{id}' THEN #{index}"
	  end
	  order_by << "END"
	  order(order_by.join(" "))
	end

	def tematica_sin_html
		return '' if self.tematica.nil? 

#		self.tematica.gsub(/<([^>]*)>/,'') #.gsub(/<script>*<\/script>/)
#		self.tematica.gsub(/\<(/?[^\>]+)\>/,'') #.gsub(/<script>*<\/script>/)
#		self.tematica.gsub(/'<script'*'script>'/)
#		self.tematica
		texto = self.tematica.gsub(/<script[^>]*>(.*?)<\/script>/,'')
		texto = texto.gsub(/<(.*?)>/,'')
		texto = texto.gsub(/Badges y certificados/,'')
#		texto = texto.gsub(/\n\r/,'')
#		texto = texto.gsub(/AUI\(\)\.ready(.*?)addClass\(cssClass\); \}/,'')
#		texto = texto.gsub(/\{(.*?)\}/,'')

    texto = texto.gsub(/^\s+/,'').gsub(/\n/,'<br />').html_safe

		texto = texto[0, 1000] if texto.length > 1500 
		return texto
	end

	def edicion_anterior_nombre
		return Curso.find(self.edicion_anterior_id).nil? ? "" : Curso.find(self.edicion_anterior_id)  
	end

	def edicion_anterior_nombre=(valor)
		self.edicion_anterior_id = Curso.find_by_nombre(valor).id
	end

  def imagen_from_url(url)
    self.imagen = open(URI.escape(url))
  end

	def proveedor_nombre
		return self.proveedor.nil? ? "" : self.proveedor.nombre 
	end

	def proveedor_nombre=(valor)
		self.proveedor = Proveedor.find_by_nombre(valor)
	end

	def universidad_nombre
		return self.universidad.nil? ? "" : self.universidad.nombre 
	end

	def universidad_nombre=(valor)
		self.universidad = Universidad.find_by_nombre(valor)
	end

	def puntuacion_estrella
		x = self.puntuacion

		x = -1 * x 

		x = x * 10

		case x
		when 0..14
			return '00'
		when 05..19
			return '05'
		when 20..24
			return '20'
		when 25..29
			return '25'
		when 30..34
			return '30'
		when 35..39
			return '35'
		when 40..44
			return '40'
		when 45..49
			return '45'
		when 50
			return '50'
		else
			return '00'
		end		
	end

	def mostrar_puntuacion
		x = -1 * self.puntuacion 

		return ' ' + x.round(2).to_s
	end

	def puntuacion
		suma = 0.0

		cuantos = 0

		tmp = self
		ant = self
		
		unless tmp.edicion_anterior_id.nil? then
			tmp = Curso.find(tmp.edicion_anterior_id)
			while not tmp.nil? and not tmp.edicion_anterior_id.nil?
	      if tmp.id == self.id then
	        tmp = nil
	      else
	      	if tmp.edicion_anterior_id.nil?
	      		ant = tmp
	      		tmp = nil
	      	else
						tmp = Curso.find(tmp.edicion_anterior_id)
					end
	      end
			end 
		end

		while not ant.nil?
			ant.evaluaciones.each do |e|
				suma = suma + e.media
				cuantos = cuantos + 1
			end

			ant = Curso.find_by_edicion_anterior_id(ant.id)

      unless ant.nil? then
	      if ant.id == self.id then
	        ant = nil
	      end
	    end
		end

		if cuantos == 0 then
			return 0
		else
			return -1 * (suma / cuantos)
		end
	end

	def puntuacion_texto
		suma = 0.0
		suma_motivacion = 0.0
		suma_representacion = 0.0
		suma_expresion = 0.0

		cuantos = 0

		tmp = self
		ant = self
		
		unless tmp.edicion_anterior_id.nil? then
			tmp = Curso.find(tmp.edicion_anterior_id)
			while not tmp.nil? and not tmp.edicion_anterior_id.nil?
	      if tmp.id == self.id then
	        tmp = nil
	      else
	      	if tmp.edicion_anterior_id.nil?
	      		ant = tmp
	      		tmp = nil
	      	else
						tmp = Curso.find(tmp.edicion_anterior_id)
					end
	      end
			end 
		end

		while not ant.nil?
			ant.evaluaciones.each do |e|
				suma = suma + e.media
				suma_motivacion = suma_motivacion + e.media_motivacion
				suma_representacion = suma_representacion + e.media_representacion
				suma_expresion = suma_expresion + e.media_expresion
				cuantos = cuantos + 1
			end

			ant = Curso.find_by_edicion_anterior_id(ant.id)

      unless ant.nil? then
	      if ant.id == self.id then
	        ant = nil
	      end
	    end
		end

		if cuantos == 0 then
			return 'Sin puntuación'#Esta línea no se puede traducir porque está contemplada en un if
		else
			return ">>>> #{I18n.t('mio.orden_busqueda_puntuacion')}: #{suma / cuantos}, 
							#{I18n.t('mio.evaluacion_motivacion')}: #{suma_motivacion}, 
							#{I18n.t('mio.evaluacion_representacion')}: #{suma_representacion}, 
							#{I18n.t('mio.evaluacion_expresion')}: #{suma_expresion}, 
							#{I18n.t('mio.de')} #{self.evaluaciones.count} #{I18n.t('mio.puntuaciones')}."
		end
	end

	def puntuacion_texto_corto
		suma = 0.0
		suma_motivacion = 0.0
		suma_representacion = 0.0
		suma_expresion = 0.0

		cuantos = 0

		tmp = self
		ant = self
		
		unless tmp.edicion_anterior_id.nil? then
			tmp = Curso.find(tmp.edicion_anterior_id)
			while not tmp.nil? and not tmp.edicion_anterior_id.nil?
	      if tmp.id == self.id then
	        tmp = nil
	      else
	      	if tmp.edicion_anterior_id.nil?
	      		ant = tmp
	      		tmp = nil
	      	else
						tmp = Curso.find(tmp.edicion_anterior_id)
					end
	      end
			end 
		end

		while not ant.nil?
			ant.evaluaciones.each do |e|
				if suma == 0.0 then
					suma = suma + e.media
					suma_motivacion = suma_motivacion + e.media_motivacion
					suma_representacion = suma_representacion + e.media_representacion
					suma_expresion = suma_expresion + e.media_expresion
				else
					suma = (suma + e.media) / 2
					suma_motivacion = (suma_motivacion + e.media_motivacion) / 2
					suma_representacion = (suma_representacion + e.media_representacion) / 2
					suma_expresion = (suma_expresion + e.media_expresion) / 2
				end
				cuantos = cuantos + 1
			end

			ant = Curso.find_by_edicion_anterior_id(ant.id)

      unless ant.nil? then
	      if ant.id == self.id then
	        ant = nil
	      end
	    end
		end

		if cuantos == 0 then
			return 'Sin puntuación' #Esta línea no se puede traducir porque está contemplada en un if
		else
			return "#{I18n.t('mio.evaluacion_motivacion')}: #{suma_motivacion.round(1).to_s}, 
							#{I18n.t('mio.evaluacion_representacion')}: #{suma_representacion.round(1).to_s}, 
							#{I18n.t('mio.evaluacion_expresion')}: #{suma_expresion.round(1).to_s} 
							#{I18n.t('mio.de')} #{self.evaluaciones.count} #{I18n.t('mio.puntuaciones')}." 
							#{'puntuación'.pluralize(self.evaluaciones.count)}."
		end
	end

	def puntuacion_grafico

		suma = 0.0
		suma_motivacion = 0.0
		suma_representacion = 0.0
		suma_expresion = 0.0

		cuantos = 0

		tmp = self
		ant = self
		
		unless tmp.edicion_anterior_id.nil? then
			tmp = Curso.find(tmp.edicion_anterior_id)
			while not tmp.nil? and not tmp.edicion_anterior_id.nil?
	      if tmp.id == self.id then
	        tmp = nil
	      else
	      	if tmp.edicion_anterior_id.nil?
	      		ant = tmp
	      		tmp = nil
	      	else
						tmp = Curso.find(tmp.edicion_anterior_id)
					end
	      end
			end 
		end

		while not ant.nil?
			ant.evaluaciones.each do |e|
				suma = suma + e.media
				suma_motivacion = suma_motivacion + e.media_motivacion
				suma_representacion = suma_representacion + e.media_representacion
				suma_expresion = suma_expresion + e.media_expresion
				cuantos = cuantos + 1
			end

			ant = Curso.find_by_edicion_anterior_id(ant.id)

      unless ant.nil? then
	      if ant.id == self.id then
	        ant = nil
	      end
	    end
		end

		return 'Sin puntuación'	if cuantos == 0 #Esta línea no se puede traducir porque está contemplada en un if

#		datos_grafico = [
#							{name: 'Media motivación', data: {'Puntuación obtenida en la motivación' => suma_motivacion}},
#							{name: 'Media representación', data: {'Puntuación obtenida en la representación' => suma_representacion}}, 
#							{name: 'Media expresión', data: {'Puntuación obtenida en la expresión' => suma_expresion}},
#							{name: 'Media total', data: {'Puntuación obtenida en total' => suma}},
#							]

		suma = suma / cuantos
		suma_motivacion = suma_motivacion / cuantos
		suma_representacion = suma_representacion / cuantos
		suma_expresion = suma_expresion / cuantos

		suma = suma.round(2)
		suma_motivacion = suma_motivacion.round(2)
		suma_representacion = suma_representacion.round(2)
		suma_expresion = suma_expresion.round(2)


		datos_grafico = [{
				name: "#{I18n.t('mio.valor_medio')} #{cuantos} " + "#{I18n.t('mio.puntuaciones')}", 
			  data: {
			  	"#{I18n.t('mio.evaluacion_motivacion')}: #{suma_motivacion}" => suma_motivacion, 
					"#{I18n.t('mio.evaluacion_representacion')}: #{suma_representacion}" => suma_representacion,
					"#{I18n.t('mio.evaluacion_expresion')}: #{suma_expresion}" => suma_expresion,
					"#{I18n.t('mio.total')}: #{suma}" => suma
				}
				}]

		return 	datos_grafico 
	end

  def to_s
    nombre
  end

end
