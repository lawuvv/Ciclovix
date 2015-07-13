json.array!(@ponto_interesses) do |ponto_interesse|
  json.extract! ponto_interesse, :id, :nome, :descricao, :endereco, :url, :tipo_id, :user_id, :enable
  json.url ponto_interess_url(ponto_interesse, format: :json)
end
