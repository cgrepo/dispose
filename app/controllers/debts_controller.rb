class DebtsController < ApplicationController
  before_action :set_vehicle, only[:create, :destroy]
  
  def create
    @debt = @vehicle.debts.new(debt_params)
    if @debt.save
      redirect_to @vehicle, notice:'Deuda creada!'
    else
      redirect_to @vehicle, alert:'No se pudo crear la deuda'
    end
  end
  
  def destroy
    @debt = @vehicle.debts.find(params[:id])
    @debt.destroy
    redirect_to @vehicle, notice:'Deuda borrada'
  end
  
  private
  #-------------------------------------------------
    def set_debt
      @vehicle = Vehicle.find(params[:vehicle_id])
    end
    
    def debt_params
      params.require(:debt).permit(:start, :end, :amount)
    end
  
end
