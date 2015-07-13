class Ponto < ActiveRecord::Base
	validates_presence_of :latitude, :longitude, :message => 'Não foi possível obter as Coordenadas do Ponto. Por favor, preencha o Endereço e clique em Buscar'
	attr_accessor :estado, :uf
	
	def validar_configuracao(params)
		if params[:estado] and params[:uf] and params[:uf] != CONFIG_UF and params[:estado] != CONFIG_ESTADO
			errors.add(:base, "O Endereço está fora do limite de #{CONFIG_ESTADO} (#{CONFIG_UF})")
		end
	end

end
