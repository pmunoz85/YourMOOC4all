json.extract! proveedor, :id, :nombre, :url, :created_at, :updated_at
json.url proveedor_url(proveedor, format: :json)
