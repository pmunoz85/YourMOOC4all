module ApplicationHelper
  
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  def menu_activo(menu)
    clase = ""
		if menu == controller_name 
			clase = 'active'
		end
    clase
  end

  def dropdown_menu_activo(menu)
    clase = ""
		if menu == controller_name 
			clase = 'active'
		end
    clase
  end

  def icon (name, white = false, options = {}) 
    n = 'icon-' + name.to_s.dasherize
    n += ' icon-white' if white
    options[:class] = n 
    content_tag(:i, nil, options)
  end 

  def array_datos(modelo)
    datos = []
    modelo.all.each do |j| 
      datos << '"' + j.nombre + '"'
    end
    return "[" + datos.join(",") + "]"
  end

  def array_datos_contactos()
    datos = []
    Contacto.all.each do |j| 
      datos << '"' + j.nif_cif + ' || ' + j.nombre + '"'
    end

    return "[" + datos.join(",") + "]"
  end

  def array_datos_descripcion(modelo)
    datos = []
    modelo.all.each do |j| 
      datos << '"' + j.descripcion + '"'
    end
    return "[" + datos.join(",") + "]"
  end

  def array_datos_interesados_dni()
    datos = []
    Interesado.order(:nif_cif).each do |j| 
      datos << '"' + j.nif_cif + '"'
    end
    return "[" + datos.join(",") + "]"
  end
	
  def highlight_pedro(texto, patron)
    return texto if patron.nil? or patron.empty?

    p = "(" + patron.join('|') + ")"
    
    exp = Regexp.new(p, true)

    coincidencia = texto.gsub(exp, "<strong class='highlight'>\\1</strong>")

    if not coincidencia.nil?
      texto = coincidencia.html_safe
    end

    return texto
  end


end
