json.extract! curso, :id, :identificador, :url, :nombre, :imagen, :proveedor_id, :universidad_id, :tematica, :informacion, :conocimientos_previos, :esfuerzo_estimado, :lenguaje_signos, :precio_auditado, :precio_credencial, :created_at, :updated_at
json.url curso_url(curso, format: :json)
