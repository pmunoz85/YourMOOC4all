class User < ActiveRecord::Base
	has_and_belongs_to_many :cursos

  has_many :evaluaciones

	rolify

#	has_many :expedientes, :dependent => :restrict_with_exception
#	has_many :tramites, :dependent => :restrict_with_exception

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	
#	validates :name, :presence => true, :uniqueness => true

	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
