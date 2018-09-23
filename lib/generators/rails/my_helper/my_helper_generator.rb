class Rails::MyHelperGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_route
    #route("resources :#{file_name.pluralize}, :except=>[:edit,:update]")
    #route("resources :pedro, :except=>[:edit,:update]")
	end

	def do_a_thing
		enlace = "					<li class='<%=menu_activo('#{file_name.pluralize}')%>'><a href='<%= #{file_name.pluralize}_url %>'><span class='glyphicon glyphicon-inbox'></span> #{file_name.camelize.pluralize}</a></li>\n"

	  case self.behavior
  	when :invoke
	    # do that stuff
			puts "Borramos la ruta original y añadimos la entrada #{file_name} en el layout."

			text = File.read("config/routes.rb").gsub(/resources :#{file_name.pluralize}/, "")
			File.open("config/routes.rb", "w") {|file| file.puts text}

			text = File.read("config/routes.rb").gsub(/\n  \n  /, "\n")
			File.open("config/routes.rb", "w") {|file| file.puts text}

			text = File.read("config/routes.rb").gsub(/\n\n/, "\n")
			File.open("config/routes.rb", "w") {|file| file.puts text}

			insert_into_file "app/views/layouts/application.html.erb", 
					enlace, 
					:after => "</span> Home</a></li>\n"
	  when :revoke
  	  # undo it!
  	  puts "Borramos la entrada #{file_name} en el layout."

			text = File.read("app/views/layouts/application.html.erb").gsub(enlace, "")
			File.open("app/views/layouts/application.html.erb", "w") {|file| file.puts text}
  	end
	end

  def add_route
	  case self.behavior
  	when :invoke
			puts "Insertamos la nueva ruta."

			t =  File.read("app/models/#{file_name.singularize}.rb").match(/nif_cif/)
			if t.to_s == 'nif_cif' then
				route <<-ROUTE.strip
  resources :#{file_name.pluralize} do
    get 'listado', :on => :collection
    get 'verificar_dni', :on => :collection
  end

	ROUTE
			else	
	route <<-ROUTE.strip
  resources :#{file_name.pluralize} do
    get 'listado', :on => :collection
  end

	ROUTE
			end
	  when :revoke
  	  # undo it!
			puts "Borramos la ruta."

			text = File.read("config/routes.rb").gsub("resources :#{file_name.pluralize} do\n    get 'listado', :on => :collection\n    get 'verificar_dni', :on => :collection\n  end", "")
			File.open("config/routes.rb", "w") {|file| file.puts text}

			text = File.read("config/routes.rb").gsub("resources :#{file_name.pluralize} do\n    get 'listado', :on => :collection\n  end", "")
			File.open("config/routes.rb", "w") {|file| file.puts text}
  	end
	end

  def create_helper_file
#    create_file "app/helpers/pedro_#{file_name}_helper.rb", <<-FILE
#module #{class_name}Helper
#  attr_reader :#{plural_name}, :#{plural_name.singularize}
#end
#    FILE
  end
end

