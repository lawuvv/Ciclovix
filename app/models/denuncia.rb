class Denuncia < ActiveRecord::Base
	belongs_to :ponto_interesse, counter_cache: true
	belongs_to :tipo
	belongs_to :user
end
