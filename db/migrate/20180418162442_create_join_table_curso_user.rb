class CreateJoinTableCursoUser < ActiveRecord::Migration
  def change
    create_join_table :cursos, :users do |t|
      t.index [:curso_id, :user_id]
      t.index [:user_id, :curso_id]
    end
  end
end
