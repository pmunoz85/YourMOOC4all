class AddObjetivosToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :objetivos, :text
    add_column :cursos, :destinatarios, :text
    add_column :cursos, :evaluacion, :text
    add_column :cursos, :inicio, :text
  end
end
