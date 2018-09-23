crumb :root do
  link "Home", root_path
end

# BUSCAR_CURSOS
crumb :inicio_usuario do
  link I18n.t('mio.miga_inicio'), root_path
end

crumb :info_curso do |p|
  link I18n.t('mio.miga_informacion'), curso_path(p)
  parent :inicio_usuario
end

crumb :editar_usuario do
  link I18n.t('mio.miga_editar_usuario'), root_path
end

crumb :identificar_usuario do
  link I18n.t('mio.miga_identificar_usuario'), root_path
end

crumb :registrar_usuario do
  link I18n.t('mio.miga_registrar_usuario'), root_path
end

crumb :olvido do
  link I18n.t('mio.miga_olvido_contrasena'), root_path
end

crumb :votar do |p|
  link p.nombre, curso_path(p)
  parent :info_curso, p
end

# CURSOS 
crumb :cursos do
  link I18n.t('mio.miga_cursos'), cursos_path
end

crumb :cursos_nuevo do
  link I18n.t('mio.miga_nuevo_curso'), cursos_path
  parent :cursos
end

crumb :curso do |p|
  link p.nombre, curso_path(p)
  parent :cursos
end

# INSTITUCIONES 
crumb :instituciones do
  link I18n.t('mio.miga_instituciones'), universidades_path
end

crumb :institucion_nuevo do
  link I18n.t('mio.miga_nueva_institucion'), universidades_path
  parent :instituciones
end

crumb :institucion do |n|
  link n.nombre, universidad_path(n)
  parent :instituciones
end

# PLATAFORMAS 
crumb :plataformas do
  link I18n.t('mio.miga_plataformas'), proveedores_path
end

crumb :plataforma_nuevo do
  link I18n.t('mio.miga_nueva_plataforma'), proveedores_path
  parent :plataformas
end

crumb :plataforma do |n|
  link n.nombre, proveedor_path(n)
  parent :plataformas
end

# IDIOMAS
crumb :idiomas do
  link I18n.t('mio.miga_idiomas'), idiomas_path
end

crumb :idioma_nuevo do
  link I18n.t('mio.miga_nuevo_idioma'), idiomas_path
  parent :idiomas
end

crumb :idioma do |n|
  link n.descripcion, idioma_path(n)
  parent :idiomas
end

# USUARIOS 
crumb :usuarios do
  link I18n.t('mio.miga_usuarios'), users_path
end

crumb :usuario_nuevo do
  link I18n.t('mio.miga_nuevo_usuario'), users_path
  parent :usuarios
end

crumb :usuario do |u|
  link u.email, user_path(u)
  parent :usuarios
end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).