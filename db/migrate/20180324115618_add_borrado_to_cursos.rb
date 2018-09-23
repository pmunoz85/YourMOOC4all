class AddBorradoToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :oculto, :boolean
  end
end
