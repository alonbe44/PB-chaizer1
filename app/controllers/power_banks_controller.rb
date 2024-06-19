class PowerBanksController < ApplicationController
  include Pundit  # Include Pundit here

  before_action :set_power_bank, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @power_banks = PowerBank.all
    authorize @power_banks  # Use `authorize` to check authorization
    # render json: @power_banks

  if params[:search].present?
    @power_banks = @power_banks.where("serial_number LIKE ?", "%#{params[:search]}%")
  end
    render("power_banks/PowerBanks")
  end


  def new
    @power_banks =   PowerBank.new
    authorize @power_banks
  end
  def show
    authorize @power_bank  # Authorize individual resource
    render json: @power_bank
  end

  def create
    @power_bank = PowerBank.new(power_bank_params)
    authorize @power_bank

    if @power_bank.save
      # render json: @power_bank, status: :created, location: @power_bank
      redirect_to power_banks_path, notice: 'Power bank was successfully created.'
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @power_bank
    if @power_bank.update(power_bank_params)
      # render json: @power_bank
            redirect_to power_banks_path, notice: 'Power bank was successfully updated.'
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end
   def edit
  @power_banks = PowerBank.find(params[:id])  # Assuming you have an ID param
  if @power_banks.present?
    authorize @power_banks
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
end

  def destroy
    authorize @power_bank
    @power_bank.destroy
    redirect_to power_banks_path, notice: 'Power bank was successfully destroyed.'
  end

  private

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

  def power_bank_params
    params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
  end
     def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end