<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
<% campos_references = [] -%>
<% attributes.select(&:reference?).each do |attribute| -%>
	belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
	<% campos_references << attribute.name -%>
<% end -%>
#  has_many :RELACIONADOS

<% if attributes.any?(&:password_digest?) -%>
	has_secure_password
<% end -%>

<%- if attributes.map{ |a| a.name }.include?('numero') -%>
	validates :numero, :presence => true #, :uniqueness => {:scope => :anyo}
	before_validation :numero_por_defecto, :on => :create
<% end -%>

<%- if attributes.map{ |a| a.name }.include?('nif_cif') -%>
	validates :nif_cif, :presence => true, :uniqueness => true
	validates :nif_cif, :valid_spanish_vat => true

	before_validation(on: :create) do
		self.nif_cif.upcase!
	end

	before_validation(on: :update) do
		self.nif_cif.upcase!
	end
<% end -%>

<% campos_references.each do |referencia| -%>
	<%- nombre_campo_externo = "descripcion" -%>
	<%- nombre_campo_externo = "nombre" if "#{referencia.camelize}".constantize.column_names.map{ |a| a }.include?('nombre') -%>
	<%- nombre_campo_externo = "name" if "#{referencia.camelize}".constantize.column_names.map{ |a| a }.include?('name') -%>
	<%- nombre_campo_externo = "descripcion" if "#{referencia.camelize}".constantize.column_names.map{ |a| a }.include?('descripcion') -%>
	def <%= referencia %>_<%= nombre_campo_externo %>
		return self.<%= referencia %>.nil? ? "" : self.<%= referencia %>.<%= nombre_campo_externo %> 
	end

	def <%= referencia %>_<%= nombre_campo_externo %>=(valor)
		self.<%= referencia %> = <%= referencia.camelize %>.find_by_<%= nombre_campo_externo %>(valor)
	end
<% end -%>

<%- nombre_campo = "descripcion" -%>
<%- nombre_campo = "nombre" if attributes.map{ |a| a.name }.include?('nombre') -%>
<%- nombre_campo = "name" if attributes.map{ |a| a.name }.include?('name') -%>
<%- nombre_campo = "descripcion" if attributes.map{ |a| a.name }.include?('descripcion') -%>
  def to_s
    <%- if attributes.map{ |a| a.name }.include?(nombre_campo) -%>
    <%= nombre_campo %>
    <%- else -%>
    "<%= class_name %> #{id}"
    <%- end -%>
  end

<%- if attributes.map{ |a| a.name }.include?('numero') -%>
private
	def self.nuevo_numero
		(<%= class_name %>.maximum(:numero) || 0).to_i.next
	end

	def numero_por_defecto
		self.numero = <%= class_name %>.nuevo_numero if self.numero.nil?
	end

<% end -%>
end
<% end -%>