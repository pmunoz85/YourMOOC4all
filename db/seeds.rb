# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ra = Role.create(:name => 'administrador')
rb = Role.create(:name => 'usuario')

u = User.create(:email => 'admin@g.es', 
								:password => '12345', 
								:password_confirmation => '12345')
u.roles << ra

u = User.create(:email => 'usuario@g.es', 
								:password => '12345', 
								:password_confirmation => '12345')
u.roles << rb



