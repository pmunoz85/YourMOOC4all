class CambiarTematicaInCursos < ActiveRecord::Migration
  def up
   change_column :cursos, :tematica, :text
  end
 
  def down
   change_column :cursos, :tematica, :string
  end
end
