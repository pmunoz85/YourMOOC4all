class CreateEvaluaciones < ActiveRecord::Migration
  def change
    create_table :evaluaciones do |t|
      t.references :user, index: true, foreign_key: true
      t.references :curso, index: true, foreign_key: true
      t.integer :motivacion_pregunta1
      t.integer :motivacion_pregunta2
      t.integer :motivacion_pregunta3
      t.integer :motivacion_pregunta4
      t.integer :motivacion_pregunta5
      t.integer :motivacion_pregunta6
      t.integer :motivacion_pregunta7
      t.integer :motivacion_pregunta8
      t.integer :motivacion_pregunta9
      t.integer :motivacion_pregunta10
      t.text :motivacion
      t.integer :representacion_pregunta11
      t.integer :representacion_pregunta12
      t.integer :representacion_pregunta13
      t.integer :representacion_pregunta14
      t.integer :representacion_pregunta15
      t.integer :representacion_pregunta16
      t.integer :representacion_pregunta17
      t.integer :representacion_pregunta18
      t.integer :representacion_pregunta19
      t.integer :representacion_pregunta20
      t.integer :representacion_pregunta21
      t.integer :representacion_pregunta22
      t.text :representacion
      t.integer :expresion_pregunta23
      t.integer :expresion_pregunta24
      t.integer :expresion_pregunta25
      t.integer :expresion_pregunta26
      t.integer :expresion_pregunta27
      t.integer :expresion_pregunta28
      t.integer :expresion_pregunta29
      t.integer :expresion_pregunta30
      t.integer :expresion_pregunta31
      t.text :expresion
      t.text :texto_libre

      t.timestamps null: false
    end
  end
end
