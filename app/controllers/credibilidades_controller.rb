class CredibilidadesController < ApplicationController
  before_action :set_credibilidade, only: [:show, :edit, :update, :destroy]

  # GET /credibilidades
  # GET /credibilidades.json
  def index
    @credibilidades = Credibilidade.all
  end

  # GET /credibilidades/1
  # GET /credibilidades/1.json
  def show
  end

  # GET /credibilidades/new
  def new
    @credibilidade = Credibilidade.new
  end

  # GET /credibilidades/1/edit
  def edit
  end

  # POST /credibilidades
  # POST /credibilidades.json
  def create
    @credibilidade = Credibilidade.new(credibilidade_params)

    respond_to do |format|
      if @credibilidade.save
        format.html { redirect_to @credibilidade, notice: 'Credibilidade was successfully created.' }
        format.json { render :show, status: :created, location: @credibilidade }
      else
        format.html { render :new }
        format.json { render json: @credibilidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credibilidades/1
  # PATCH/PUT /credibilidades/1.json
  def update
    respond_to do |format|
      if @credibilidade.update(credibilidade_params)
        format.html { redirect_to @credibilidade, notice: 'Credibilidade was successfully updated.' }
        format.json { render :show, status: :ok, location: @credibilidade }
      else
        format.html { render :edit }
        format.json { render json: @credibilidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credibilidades/1
  # DELETE /credibilidades/1.json
  def destroy
    @credibilidade.destroy
    respond_to do |format|
      format.html { redirect_to credibilidades_url, notice: 'Credibilidade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credibilidade
      @credibilidade = Credibilidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credibilidade_params
      params.require(:credibilidade).permit(:valor, :user_id, :enable, :type)
    end
end
