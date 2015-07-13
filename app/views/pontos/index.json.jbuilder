json.array!(@pontos) do |ponto|
  json.extract! ponto, :id, :latitude, :longitude, :altitude
  json.url ponto_url(ponto, format: :json)
end
