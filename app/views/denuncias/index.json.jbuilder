json.array!(@denuncia) do |denuncia|
  json.extract! denuncia, :id, :user_id, :ponto_interesse_id, :rota_id, :motivo_id, :type
  json.url denuncia_url(denuncia, format: :json)
end
