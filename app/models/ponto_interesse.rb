class PontoInteresse < ActiveRecord::Base
	belongs_to :ponto
	belongs_to :tipo
	belongs_to :user
	has_many :credibilidade_pontos, dependent: :destroy
	has_many :denuncias, dependent: :destroy
	validates :nome, :presence => {:message => ' não pode ficar em branco'}
	validates :endereco, :presence => {:message => ' não pode ficar em branco'}
	validates :tipo_id, :presence => {:message => ' precisa ser selecionado'}
	mount_uploader :foto, FotoUploader

	# retorna um string que formata as informações de um ponto ao ser clicado no mapa
	def infowindow
	"
	<b>Tipo:</b> #{tipo.descricao}<br />
	<b>Nome:</b> #{nome}<br />
	<b>Descrição:</b> #{descricao}<br />
	<b>Endereco:</b> #{endereco}<br />
	<b>Url:</b> #{url}<br />
	<div class='detalhes-infowindow'><a href='/ponto_interesses/#{id}'>+ detalhes</a></div>
	"
	end

	# recebe um array de id's de tipos, e retorna a listagem de pontos baseado no filtro
	def self.get_pontos(tipo_ponto_filtro)
		tipo_ids = '0'
		tipo_ponto_filtro.each do |item|
			tipo_ids << ",#{item}"
 		end
 		where("tipo_id IN (#{tipo_ids}) and enable = true")
	end

	# retorna um hash com os pontos de interesse formatados
	def self.markers(pontos)
		Gmaps4rails.build_markers(pontos) do |ponto, marker|
			marker.lat ponto.ponto.latitude
			marker.lng ponto.ponto.longitude
			marker.picture({
			"url" => "assets/#{ponto.tipo.marcador}",
			"width" =>  32,
			"height" => 37})
			marker.infowindow ponto.infowindow
		end
	end

	# retorna um hash com o ponto de interesse formatado
	def self.marker(ponto)
		Gmaps4rails.build_markers(ponto) do |ponto, marker|
			marker.lat ponto.ponto.latitude
			marker.lng ponto.ponto.longitude
			marker.infowindow ponto.infowindow
		end
	end

	# retorna a quantidade de credibilidades positivas de um ponto
	def credibilidade_positiva
		credibilidade_pontos.where("valor > 0").count
	end

	# retorna a quantidade de credibilidades negativas de um ponto
	def credibilidade_negativa
		credibilidade_pontos.where("valor < 0").count
	end

	# desabilita um Ponto
	def self.desabilitar(ponto_id)
		if (ponto_id and ponto_id.to_i.to_s == ponto_id)
			ponto = PontoInteresse.find(ponto_id)
			if (ponto)
				ponto.enable = !ponto.enable
				ponto.save
			end
		end
	end

	# excluir um Ponto
	def self.excluir(ponto_id)
		if (ponto_id and ponto_id.to_i.to_s == ponto_id)
			ponto = PontoInteresse.find(ponto_id)
			if (ponto)
				ponto.destroy
			end
		end
	end

end
