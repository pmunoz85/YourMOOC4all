class AddImagenToCursos < ActiveRecord::Migration
  def up
	remove_column :cursos, :imagen
    add_attachment :cursos, :imagen
  end
 
  def down
    remove_attachment :cursos, :imagen
	add_column :cursos, :imagen, :string
  end
end
