class ModificaStringToTextFromCursos < ActiveRecord::Migration
	def up
	    change_column :cursos, :conocimientos_previos, :text
	end
	def down
	    change_column :cursos, :conocimientos_previos, :string
	end
end
