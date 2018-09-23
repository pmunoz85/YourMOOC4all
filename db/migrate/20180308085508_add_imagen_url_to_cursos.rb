class AddImagenUrlToCursos < ActiveRecord::Migration
  def change
		add_column :cursos, :imagen_url, :string
  end
end
