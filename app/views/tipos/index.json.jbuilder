json.array!(@tipos) do |tipo|
  json.extract! tipo, :id, :type, :descricao, :marcador, :enable
  json.url tipo_url(tipo, format: :json)
end
