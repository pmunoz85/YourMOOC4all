class AddEdicionAnteriorToEvaluaciones < ActiveRecord::Migration
  def change
    add_reference :cursos, :edicion_anterior, index: true #, foreign_key: true
  end
end
