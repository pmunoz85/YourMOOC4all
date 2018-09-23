class AddFieldsToEvaluaciones < ActiveRecord::Migration
  def change
    add_column :evaluaciones, :experiencia, :string
    add_column :evaluaciones, :progreso, :string
  end
end
