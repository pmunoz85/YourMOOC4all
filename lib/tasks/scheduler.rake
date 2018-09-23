namespace :cursos do

	desc "Esta tarea es llamada desde Heroku scheduler add-on"
	task :update => :environment do
	  puts "Actualizando cursos ..."

	  puts "... Comienza el análisis de UNED Abierta"
		w = Uned.new
		w.crawler('UNED Abierta', 'https://iedra.uned.es')

	  puts "... Comienza el análisis de Miriadax"
		w = Miriadax.new 
		w.crawler('MiriadaX', 'https://miriadax.net')

	  puts "... Comienza el análisis de Coursera"
		w = Coursera.new  
		w.crawler('Coursera', 'https://www.coursera.org')

	  puts "... Comienza el análisis de edX"
		w = Edx.new 	
		w.crawler('edX', 'https://www.edx.org')

	  puts "Actualzación terminada."
	end

end
