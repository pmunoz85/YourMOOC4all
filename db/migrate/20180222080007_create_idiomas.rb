class CreateIdiomas < ActiveRecord::Migration
  def change
    create_table :idiomas do |t|
      t.string :descripcion

      t.timestamps null: false
    end
  end
end
