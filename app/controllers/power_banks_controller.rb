# class PowerBanksController < ApplicationController
#   before_action :set_power_bank, only: [:show, :update, :destroy]
#   before_action :authenticate_user!
#   after_action :verify_authorized
#
#   def index
#     @power_banks = PowerBank.all
#     authorize @power_banks
#     render json: @power_banks
#   end
#
#   def show
#     authorize @power_bank
#     render json: @power_bank
#   end
#
#   def create
#     @power_bank = PowerBank.new(power_bank_params)
#     authorize @power_bank
#
#     if @power_bank.save
#       render json: @power_bank, status: :created, location: @power_bank
#     else
#       render json: @power_bank.errors, status: :unprocessable_entity
#     end
#   end
#
#   def update
#     authorize @power_bank
#     if @power_bank.update(power_bank_params)
#       render json: @power_bank
#     else
#       render json: @power_bank.errors, status: :unprocessable_entity
#     end
#   end
#
#   def destroy
#     authorize @power_bank
#     @power_bank.destroy
#   end
#
#   private
#
#   def set_power_bank
#     @power_bank = PowerBank.find(params[:id])
#   end
#
#   def power_bank_params
#     params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
#   end
# end


# class PowerBanksController < ApplicationController
#   before_action :set_power_bank, only: [:show, :update, :destroy]
#   before_action :authenticate_user!
#   after_action :verify_authorized
#
#   def index
#     @power_banks = PowerBank.all
#     authorize @power_banks
#     render json: @power_banks
#   end
#
#   def show
#     authorize @power_bank
#     render json: @power_bank
#   end
#
#   def create
#     @power_bank = PowerBank.new(power_bank_params)
#     authorize @power_bank
#
#     if @power_bank.save
#       render json: @power_bank, status: :created, location: @power_bank
#     else
#       render json: @power_bank.errors, status: :unprocessable_entity
#     end
#   end
#
#   def update
#     authorize @power_bank
#     if @power_bank.update(power_bank_params)
#       render json: @power_bank
#     else
#       render json: @power_bank.errors, status: :unprocessable_entity
#     end
#   end
#
#   def destroy
#     authorize @power_bank
#     @power_bank.destroy
#   end
#
#   private
#
#   def set_power_bank
#     @power_bank = PowerBank.find(params[:id])
#   end
#
#   def power_bank_params
#     params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
#   end
# end



class PowerBanksController < ApplicationController
  include Pundit  # Include Pundit here

  before_action :set_power_bank, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @power_banks = PowerBank.all
    authorize @power_banks  # Use `authorize` to check authorization
    render json: @power_banks
  end

  def show
    authorize @power_bank  # Authorize individual resource
    render json: @power_bank
  end

  def create
    @power_bank = PowerBank.new(power_bank_params)
    authorize @power_bank

    if @power_bank.save
      render json: @power_bank, status: :created, location: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @power_bank
    if @power_bank.update(power_bank_params)
      render json: @power_bank
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @power_bank
    @power_bank.destroy
  end

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
  end
end