class EnterosController < ApplicationController
  before_action :set_entero, only: [:show, :edit, :update, :destroy]

  # GET /enteros
  # GET /enteros.json
  def index
    @enteros = Entero.all
  end

  # GET /enteros/1
  # GET /enteros/1.json
  def show
  end

  # GET /enteros/new
  def new
    @entero = Entero.new
  end

  # GET /enteros/1/edit
  def edit
  end

  # POST /enteros
  # POST /enteros.json
  def create
    #byebug
    @entero = Entero.new(entero_params)

      respond_to do |format|
        if @entero.save
          format.html  { redirect_to @entero, notice: 'Entero was successfully created.' }
          format.json { render :show, status: :created, location: @entero }
          format.js
        else
          format.html { render :new }
          format.json { render json: @entero.errors, status: :unprocessable_entity }
        end
      end
  end
  
  # PATCH/PUT /enteros/1
  # PATCH/PUT /enteros/1.json
  def update
    respond_to do |format|
      if @entero.update(entero_params)
        format.html { redirect_to @entero, notice: 'Entero was successfully updated.' }
        format.json { render :show, status: :ok, location: @entero }
      else
        format.html { render :edit }
        format.json { render json: @entero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enteros/1
  # DELETE /enteros/1.json
  def destroy
    @entero.destroy
    respond_to do |format|
      format.html { redirect_to enteros_url, notice: 'Entero was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def insertServices
    
    respond_to do |format|
        format.js
      end
  end
  
  def deleteServices
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entero
      @entero = Entero.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entero_params
      params.require(:entero).permit(:taxpayer, :service, :unit, :quantity)
    end
end
