# -*- encoding : utf-8 -*-
<% if namespaced? -%>

require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  load_and_authorize_resource skip_load_resource only: [:create] 
  
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  def listado
    datos = []
    <%= singular_table_name.camelize %>.all.each do |j| 
      <%- nombre_campo = "descripcion" -%>
      <%- nombre_campo = "nombre" if attributes.map{ |a| a.name }.include?('nombre') -%>
      <%- nombre_campo = "name" if attributes.map{ |a| a.name }.include?('name') -%>
      <%- nombre_campo = "descripcion" if attributes.map{ |a| a.name }.include?('descripcion') -%>
      datos << j.<%= nombre_campo %> 
    end

    render :json => datos.to_json
  end

<%- if attributes.map{ |a| a.name }.include?('nif_cif') -%>
  def verificar_dni
    interesado = <%= class_name %>.find_by_nif_cif(params[:numero_dni])

    if interesado.nil? then
      texto = 'false'
    else
      texto = 'true'
    end

    render :json => texto.to_json
  end
<% end -%>

  def index
#    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    @<%= plural_table_name %> = <%= singular_table_name.camelize %>.paginate(:page => params[:page], :per_page => 20)
  end

  def show
#    @registros = @<%= singular_table_name %>.RELACIONADOS.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to <%= plural_table_name %>_url, notice: <%= "'#{human_name} fue creado correctamente.'" %>
    else
      render action: 'new'
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: <%= "'#{human_name} fue actualizado correctamente.'" %>
    else
      render action: 'edit'
    end
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} fue borrado correctamente.'" %>
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[<%= ":#{singular_table_name}" %>]
      <%- else -%>
      #params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
<% campos_references = [] -%>
<% attributes.select(&:reference?).each do |attribute| -%>
  <% campos_references << attribute.name + '_descripcion' -%>
  <% campos_references << attribute.name + '_nombre' -%>
  <% campos_references << attribute.name + '_name' -%>
<% end -%>
<% attributes_names.each { |name| campos_references << name } %>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= campos_references.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>

