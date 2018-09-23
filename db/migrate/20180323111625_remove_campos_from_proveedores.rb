class RemoveCamposFromProveedores < ActiveRecord::Migration
  def change
    remove_column :proveedores, :apartado, :string
    remove_column :proveedores, :lista_cursos, :string
    remove_column :proveedores, :nombre_curso, :string
    remove_column :proveedores, :universidad, :string
    remove_column :proveedores, :tematica, :string
    remove_column :proveedores, :informacion, :string
    remove_column :proveedores, :esfuerzo, :string
    remove_column :proveedores, :pagina_siguiente, :string
  end
end
