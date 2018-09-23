# -*- encoding : utf-8 -*-
class Mineria

	def busca_texto_informacion(el_texto, target, cadenas)

		texto_en_plano = []
		el_texto.each do |linea|
			texto_en_plano << linea
		end
		texto_en_plano = texto_en_plano.join

		h = {}
		cadenas.each do |c|
			if texto_en_plano.index(c)
				h[c] = texto_en_plano.index(c)
			end
		end
		h = h.sort_by {|key, value| value}.to_h

		primero = true
		segundo = true 
		final = ''
		h.each do |key, value|
			if primero then
				if key == target then
					primero = false
				end
			else
				if segundo then
					segundo = false
					final = key
				end
			end
		end

		objetivos = ''
		if texto_en_plano.index(/#{target}/)
			
			objetivos = texto_en_plano[/#{target}(.*?)#{final}/m, 1].strip
#			objetivos = texto_en_plano.scan(/#{target}(.*)#{final}/m).join
		end
		return objetivos

	end	

end