class DenunciasController < ApplicationController
  before_action :set_denuncia, only: [:show, :edit, :update, :destroy]

  # GET /denuncias
  # GET /denuncias.json
  def index
    @denuncias = Denuncia.all
  end

  # GET /denuncias/1
  # GET /denuncias/1.json
  def show
  end

  # GET /denuncias/new
  def new
    @denuncia = Denuncia.new
  end

  # GET /denuncias/1/edit
  def edit
  end

  # POST /denuncias
  # POST /denuncias.json
  def create
    @denuncia = Denuncia.new(denuncia_params)

    respond_to do |format|
      if @denuncia.save
        format.html { redirect_to @denuncia, notice: 'Denuncia salva com sucesso.' }
        format.json { render :show, status: :created, location: @denuncia }
      else
        format.html { render :new }
        format.json { render json: @denuncia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /denuncias/1
  # PATCH/PUT /denuncias/1.json
  def update
    respond_to do |format|
      if @denuncia.update(denuncia_params)
        format.html { redirect_to @denuncia, notice: 'Denuncia atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @denuncia }
      else
        format.html { render :edit }
        format.json { render json: @denuncia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /denuncias/1
  # DELETE /denuncias/1.json
  def destroy
    @denuncia.destroy
    respond_to do |format|
      format.html { redirect_to denuncia_url, notice: 'Denuncia foi excluida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_denuncia
      @denuncia = Denuncia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def denuncia_params
      params.require(:denuncia).permit(:user_id, :ponto_interesse_id, :rota_id, :motivo_id, :type)
    end
end
