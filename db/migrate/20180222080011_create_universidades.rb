class CreateUniversidades < ActiveRecord::Migration
  def change
    create_table :universidades do |t|
      t.string :nombre

      t.timestamps null: false
    end
  end
end
