class RemoveIdentificadorCursoFromProveedores < ActiveRecord::Migration
  def change
    remove_column :proveedores, :identificador_curso, :string
  end
end
