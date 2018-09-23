class Audio < ActiveRecord::Base
	belongs_to :curso
	belongs_to :idioma

	validates :curso_id, :presence => true
	validates :idioma_id, :presence => true

	def curso_nombre
		return self.curso.nil? ? "" : self.curso.nombre 
	end

	def curso_nombre=(valor)
		self.curso = Curso.find_by_nombre(valor)
	end
	def idioma_descripcion
		return self.idioma.nil? ? "" : self.idioma.descripcion 
	end

	def idioma_descripcion=(valor)
		self.idioma = Idioma.find_by_descripcion(valor)
	end

	def to_s
		"Audio #{id}"
	end

end
