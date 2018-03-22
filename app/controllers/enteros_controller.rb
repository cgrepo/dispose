class EnterosController < ApplicationController
  before_action :set_entero, only: [:show, :edit, :update, :destroy]

  # GET /enteros
  # GET /enteros.json
  def index
    #@enteros = Entero.all.order(:id).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.order(:created_at).order(:concessionary_id).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.order(:concessionary_id).group(:created_at).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.order(:created_at).order(:concessionary_id).group(:concessionary_id).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.order(:concessionary_id).group(:created_at).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.group(:created_at).group(:concessionary_id).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.group(:concessionary_id).group(:created_at).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.group(:concessionary_id,:created_at).order(created_at: :desc).paginate(page: params[:page], per_page:20)
    ###@enteros = Entero.all.group(:created_at).order(:concessionary_id).group(:concessionary_id).paginate(page: params[:page], per_page:20)
    # @enteros = Entero.where(concessionary_id:@e.concessionary).where("created_at LIKE '%2017-04-07 %'").group(:created_at).paginate(page: params[:page], per_page:20)
    #@enteros = Entero.all.group(:taxpayer, :created_at).order(created_at: :desc).paginate(page: params[:page], per_page:20)
    @enteros = Entero.all.group(:taxpayer).order(created_at: :desc).paginate(page: params[:page], per_page:20)
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
    @entero = Entero.new(entero_params)
      respond_to do |format|
        if @entero.save
          format.html  { redirect_to @entero, notice: 'Entero fue creado.' }
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
        format.html { redirect_to @entero, notice: 'Entero actualizado.' }
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
      format.html { redirect_to enteros_url, notice: 'Entero borrado.' }
      format.json { head :no_content }
    end
  end

  def insertServices
    respond_to do |format|
        format.js
      end
  end
  
  def putService
    @entero = Entero.new(entero_params)
    @entero.concessionary = set_concessionary
    
    respond_to do |format|
      if @entero.save
        format.json { render :show, status: :created, location: @entero }
        format.js
      end
    end
  end
  
  def deleteServices
    respond_to do |format|
      format.js
    end
  end
  
  def popService
    set_entero
    @entero.destroy
    respond_to do |format|
      format.json { head :no_content, notice: 'Entero was successfully destroyed.'}
      format.js
    end
  end
  
  def buildPdf
    respond_to do |format|
      format.js
    end
  end
  
  def showEntero
    @enteros = Entero.where id: params[:totals].split(',')
    
    respond_to do |format|
      format.html do
        
        pdf = EnteroPdf.new(@enteros)
        send_data pdf.render,
          filename: "entero_relleno.pdf",
          type: 'application/pdf',
          disposition: 'inline'
        end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entero
      @entero = Entero.find(params[:id])
    end
    
    def set_concessionary
      Concessionary.find_by name:entero_params[:taxpayer]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def entero_params
      params.require(:entero).permit(:taxpayer, :service, :unit, :quantity)
    end
end
