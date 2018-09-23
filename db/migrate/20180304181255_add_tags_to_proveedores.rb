class AddTagsToProveedores < ActiveRecord::Migration
  def change
	add_column :proveedores, :apartado, :string
	add_column :proveedores, :lista_cursos, :string
	add_column :proveedores, :identificador_curso, :string
	add_column :proveedores, :nombre_curso, :string
	add_column :proveedores, :universidad, :string
	add_column :proveedores, :tematica, :string
	add_column :proveedores, :informacion, :string
	add_column :proveedores, :esfuerzo, :string
	add_column :proveedores, :pagina_siguiente, :string
  end
end

