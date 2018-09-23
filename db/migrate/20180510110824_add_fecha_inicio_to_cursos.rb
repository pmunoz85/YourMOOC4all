class AddFechaInicioToCursos < ActiveRecord::Migration
  def change
    add_column :cursos, :fecha_inicio, :date
  end
end
