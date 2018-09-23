class Universidad < ActiveRecord::Base
  has_many :cursos

#  has_many :RELACIONADOS





  def to_s
    nombre
  end

end
