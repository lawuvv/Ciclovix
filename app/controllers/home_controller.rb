class HomeController < ApplicationController
	def index
		@tipos = Tipo.where(enable: true)
		@tipo_ponto_todos = @tipos.where(type: "TipoPonto").order(:descricao)
		@tipo_ponto_filtro = obter_filtro_tipos
		@tipo_rota_todos = @tipos.where(type: "TipoRota").order(:id)
		@pontos = PontoInteresse.get_pontos(@tipo_ponto_filtro)
		@hash = PontoInteresse.markers(@pontos)

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @pontos }
		end
	end

	def create
		@tipos = Tipo.where(enable: true)
		@tipo_ponto_todos = @tipos.where(type: "TipoPonto").order(:descricao)
		@tipo_ponto_filtro = obter_filtro_tipos
		@tipo_rota_todos = @tipos.where(type: "TipoRota").order(:id)
		@pontos = PontoInteresse.get_pontos(@tipo_ponto_filtro)
		@hash = PontoInteresse.markers(@pontos)
		render "index"
	end

	# obtem os filtros da tela
	# se não houver, retorna todos
	def obter_filtro_tipos
		filtro = [0]
		if (params[:tipo_ponto])
			params[:tipo_ponto].each do |value|
				filtro << value
			end
		else
			@tipo_ponto_todos.each do |tipo|
				filtro << tipo.id
			end
		end
		filtro
	end

	# realiza a seleção do checkbox na tela
	def checkbox_ponto_selecionado(id)
		@tipo_ponto_filtro.each do |item|
			return true if item.to_s == id.to_s
 		end
 		false
	end
	helper_method :checkbox_ponto_selecionado

end
