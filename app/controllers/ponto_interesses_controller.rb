class PontoInteressesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :set_ponto_interess, only: [:show, :edit, :update, :destroy, :denunciar]
  before_action only: [:edit, :update, :destroy] do
    authenticate_edit_point(@ponto_interesse)
  end
  before_action only: [:show] do
    authenticate_show_point(@ponto_interesse)
  end


  # GET /ponto_interesses
  # GET /ponto_interesses.json
  def index
    @ponto_interesses = PontoInteresse.where(:user_id => current_user.id)
    @hash = PontoInteresse.markers(@ponto_interesses)
  end


  # GET /ponto_interesses/1
  # GET /ponto_interesses/1.json
  def show
    credibilizar
    @tipo_denuncia = TipoDenuncia.where(enable: true).order(:descricao)
  end


  # GET /ponto_interesses/new
  def new
    @ponto_interesse = PontoInteresse.new
    @tipos = TipoPonto.where(enable: true).order(:descricao)
  end


  # GET /ponto_interesses/1/edit
  def edit
    @tipos = TipoPonto.where(enable: true).order(:descricao)
  end


  # POST /ponto_interesses
  # POST /ponto_interesses.json
  def create
    @tipos = TipoPonto.where(enable: true).order(:descricao)
    @ponto_interesse = PontoInteresse.new(ponto_interess_params)
    ponto = Ponto.new(ponto_params)
    ponto.validar_configuracao(ponto_params)
    respond_to do |format|
      if ponto.valid? and @ponto_interesse.valid? and ponto.save
        @ponto_interesse.ponto_id = ponto.id
        @ponto_interesse.user_id = current_user.id
        @ponto_interesse.save
        format.html { redirect_to @ponto_interesse, notice: 'Ponto criado com sucesso' }
        format.json { render :show, status: :created, location: @ponto_interesse }
      else
        if ponto.errors.any?
          @ponto_interesse.errors.add(:base, "Coordenadas inválidas. Favor buscar o Endereço")
        end
        format.html { render :new }
        format.json { render json: @ponto_interesse.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /ponto_interesses/1
  # PATCH/PUT /ponto_interesses/1.json
  def update
    @tipos = TipoPonto.where(enable: true).order(:descricao)
    ponto = Ponto.find(@ponto_interesse.ponto_id)
    ponto.latitude = ponto_params[:latitude]
    ponto.longitude = ponto_params[:longitude]
    ponto.validar_configuracao(ponto_params)

    respond_to do |format|
      if ponto.valid? and @ponto_interesse.valid? and ponto.save and @ponto_interesse.update(ponto_interess_params)
        format.html { redirect_to @ponto_interesse, notice: 'Ponto atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @ponto_interesse }
      else
        if ponto.errors.any?
          @ponto_interesse.errors.add(:base, "Coordenadas inválidas. Favor buscar o Endereço")
        end
        format.html { render :edit }
        format.json { render json: @ponto_interesse.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /ponto_interesses/1
  # DELETE /ponto_interesses/1.json
  def destroy
    @ponto_interesse.destroy
    respond_to do |format|
      format.html { redirect_to ponto_interesses_url, notice: 'Ponto excluido com sucesso' }
      format.json { head :no_content }
    end
  end


  # cria um voto de credibilidade positiva ou negativa para o ponto envolvido
  # se existir um voto, o sistema atualiza o voto para o contrário
  def credibilizar
    valor = nil

    if params[:credibilizar]
      if !user_signed_in?
        flash[:error] = 'É necessário estar logado para Credibilizar o Ponto'
      elsif params[:credibilizar] == '+'
        valor = 1
      elsif params[:credibilizar] == '-'
        valor = -1
      end
    end

    if valor
      credibilidade = CredibilidadePonto.where(:user_id => current_user.id, :ponto_interesse_id => @ponto_interesse.id).first
      credibilidade ||= CredibilidadePonto.new(:user_id => current_user.id, :ponto_interesse_id => @ponto_interesse.id)
      credibilidade.valor = valor
      credibilidade.save
    end
  end


  # Realiza uma denuncia
  def denunciar
    denuncia = Denuncia.new
    denuncia.ponto_interesse_id = @ponto_interesse.id
    denuncia.user_id = current_user.id if user_signed_in?
    denuncia.motivo_id = params[:tipo_denuncia]

    @tipo_denuncia = TipoDenuncia.where(enable: true).order(:descricao)

    respond_to do |format|
      if verify_recaptcha && denuncia.save
        format.html { render :show, notice: 'Denuncia cadastrada com sucesso!' }
        format.json { render json: 'Denuncia cadastrada com sucesso!', status: :ok }
        format.js { head :ok, status: :ok }
      else
        format.html { render :show, error: 'Denuncia não concretizada! Você não passou no teste do Robô' }
        format.json { render json: 'Denuncia não concretizada! Você não passou no teste do Robô', status: :error }
        format.js { head :error, status: :error }
      end
    end
  end


  # Retorna a contagem de credibilidades positivas e negativas do ponto
  def credibilidades(c)
    if c == '+'
      @ponto_interesse.credibilidade_positiva
    elsif c == '-'
      @ponto_interesse.credibilidade_negativa
    end
  end
  helper_method :credibilidades


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ponto_interess
      @ponto_interesse = PontoInteresse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ponto_interess_params
      params.require(:ponto_interesse).permit(
        :nome, :descricao, :endereco, :url, :tipo_id,
        :ponto_id, :foto, :foto_cache, :remove_foto)
    end

    def ponto_params
      params.require(:ponto).permit(:latitude, :longitude, :estado, :uf)
    end
end