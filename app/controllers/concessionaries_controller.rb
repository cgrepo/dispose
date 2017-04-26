class ConcessionariesController < ApplicationController
  before_action :set_concessionary, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :get_byName
  
  # GET /concessionaries
  # GET /concessionaries.json
  def index
    @concessionaries = Concessionary.all.order(:name).paginate(page: params[:page], per_page:20)
  end

  # GET /concessionaries/1
  # GET /concessionaries/1.json
  def show
  end

  # GET /concessionaries/new
  def new
    @concessionary = Concessionary.new
  end

  # GET /concessionaries/1/edit
  def edit
  end

  # POST /concessionaries
  # POST /concessionaries.json
  def create
    @concessionary = Concessionary.new(concessionary_params)

    respond_to do |format|
      if @concessionary.save
        format.html { redirect_to @concessionary, notice: 'Concessionario creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @concessionary }
      else
        format.html { render :new }
        format.json { render json: @concessionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concessionaries/1
  # PATCH/PUT /concessionaries/1.json
  def update
    respond_to do |format|
      if @concessionary.update(concessionary_params)
        format.html { redirect_to @concessionary, notice: 'Concessionario actualizado.' }
        format.json { render :show, status: :ok, location: @concessionary }
      else
        format.html { render :edit }
        format.json { render json: @concessionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concessionaries/1
  # DELETE /concessionaries/1.json
  def destroy
    @concessionary.destroy
    respond_to do |format|
      format.html { redirect_to concessionaries_url, notice: 'Concessionario fue borrado.' }
      format.json { head :no_content }
    end
  end
  
  def get_byName
    #byebug
    @concessionaries = Concessionary.where("name LIKE ?",'%'+params[:name]+'%')
    
    respond_to do |format|
      format.js {}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concessionary
      @concessionary = Concessionary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concessionary_params
      params.require(:concessionary).permit(:name, :telephone)
    end
end
