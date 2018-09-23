class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :identificador
      t.string :url
      t.string :nombre
      t.string :imagen
      t.references :proveedor, index: true, foreign_key: true
      t.references :universidad, index: true, foreign_key: true
      t.string :tematica
      t.text :informacion
      t.string :conocimientos_previos
      t.string :esfuerzo_estimado
      t.boolean :lenguaje_signos
      t.string :precio_auditado
      t.string :precio_credencial

      t.timestamps null: false
    end
  end
end
