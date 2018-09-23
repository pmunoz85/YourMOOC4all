class Evaluacion < ActiveRecord::Base
	belongs_to :user
		belongs_to :curso

	validates :curso_id, :presence => true
	validates :user_id, :presence => true

	def media
		suma = 0.0
		contador = 0
		campos = ['motivacion_pregunta1', 
							'motivacion_pregunta2', 
							'motivacion_pregunta3', 
							'motivacion_pregunta4', 
							'motivacion_pregunta5', 
							'motivacion_pregunta6', 
							'motivacion_pregunta7', 
							'motivacion_pregunta8', 
							'motivacion_pregunta9', 
							'motivacion_pregunta10', 
							'representacion_pregunta11', 
							'representacion_pregunta12', 
							'representacion_pregunta13', 
							'representacion_pregunta14', 
							'representacion_pregunta15', 
							'representacion_pregunta16', 
							'representacion_pregunta17', 
							'representacion_pregunta18', 
							'representacion_pregunta19', 
							'representacion_pregunta20', 
							'representacion_pregunta21', 
							'representacion_pregunta22', 
							'expresion_pregunta23', 
							'expresion_pregunta24', 
							'expresion_pregunta25', 
							'expresion_pregunta26', 
							'expresion_pregunta27', 
							'expresion_pregunta28', 
							'expresion_pregunta29', 
							'expresion_pregunta30', 
							'expresion_pregunta31']
		campos.each do |c|
			unless eval(c).nil?
				suma = suma + eval(c) 
				contador = contador + 1
			end
		end

		if contador == 0 then
			return 0
		else
			return suma / contador
		end
	end

	def media_motivacion
		suma = 0.0
		contador = 0
		campos = ['motivacion_pregunta1', 
							'motivacion_pregunta2', 
							'motivacion_pregunta3', 
							'motivacion_pregunta4', 
							'motivacion_pregunta5', 
							'motivacion_pregunta6', 
							'motivacion_pregunta7', 
							'motivacion_pregunta8', 
							'motivacion_pregunta9', 
							'motivacion_pregunta10']

		campos.each do |c|
			unless eval(c).nil?
				suma = suma + eval(c) 
				contador = contador + 1
			end
		end

		if contador == 0 then
			return 0
		else
			return suma / contador
		end
	end

	def media_representacion
		suma = 0.0
		contador = 0
		campos = ['representacion_pregunta11', 
							'representacion_pregunta12', 
							'representacion_pregunta13', 
							'representacion_pregunta14', 
							'representacion_pregunta15', 
							'representacion_pregunta16', 
							'representacion_pregunta17', 
							'representacion_pregunta18', 
							'representacion_pregunta19', 
							'representacion_pregunta20', 
							'representacion_pregunta21', 
							'representacion_pregunta22']

		campos.each do |c|
			unless eval(c).nil?
				suma = suma + eval(c) 
				contador = contador + 1
			end
		end

		if contador == 0 then
			return 0
		else
			return suma / contador
		end
	end

	def media_expresion
		suma = 0.0
		contador = 0
		campos = ['expresion_pregunta23', 
							'expresion_pregunta24', 
							'expresion_pregunta25', 
							'expresion_pregunta26', 
							'expresion_pregunta27', 
							'expresion_pregunta28', 
							'expresion_pregunta29', 
							'expresion_pregunta30', 
							'expresion_pregunta31']

		campos.each do |c|
			unless eval(c).nil?
				suma = suma + eval(c) 
				contador = contador + 1
			end
		end

		if contador == 0 then
			return 0
		else
			return suma / contador
		end
	end

	def user_email
		return self.user.nil? ? "" : self.user.email 
	end

	def user_email=(valor)
		self.user = User.find_by_email(valor)
	end
	
	def curso_nombre
		return self.curso.nil? ? "" : self.curso.nombre 
	end

	def curso_nombre=(valor)
		self.curso = Curso.find_by_nombre(valor)
	end

  def to_s
    "Evaluacion #{id}"
  end

end
