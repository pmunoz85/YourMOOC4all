class Idioma < ActiveRecord::Base
  has_many :subtitulos

  has_many :audios

  has_many :transcripciones

  def to_s
    descripcion
  end

end
