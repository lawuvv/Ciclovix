json.array!(@credibilidades) do |credibilidade|
  json.extract! credibilidade, :id, :valor, :user_id, :enable, :type
  json.url credibilidade_url(credibilidade, format: :json)
end
