class AdminPontosController < ApplicationController

	before_action :authenticate_admin # permite que apenas administradores acessem

	def index
		executar_acoes
		@pontos = PontoInteresse.all.order("enable DESC, denuncias_count DESC, created_at DESC").page(params[:page])
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @pontos }
		end
	end

	def executar_acoes
		if (params[:ponto_id] and params[:ponto_acao])
			case params[:ponto_acao]
			when 'DESABILITAR'
				resultado = PontoInteresse.desabilitar(params[:ponto_id])
			when 'EXCLUIR'
				resultado = PontoInteresse.excluir(params[:ponto_id])
			end

			if (resultado)
				flash[:success] = 'Ação realizada com sucesso'
			else
				flash[:error] = 'Erro ao executar a Ação'
			end
		end
	end

end
