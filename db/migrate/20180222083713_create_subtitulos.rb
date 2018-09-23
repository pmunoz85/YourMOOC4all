class CreateSubtitulos < ActiveRecord::Migration
  def change
    create_table :subtitulos do |t|
      t.references :curso, index: true, foreign_key: true
      t.references :idioma, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
