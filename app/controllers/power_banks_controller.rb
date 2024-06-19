class PowerBanksController < ApplicationController
  include Pundit  # Include Pundit here

  before_action :set_power_bank, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

# GET /power banks
# Fetches all power banks and renders them in a view.
# Check if Search param is present, if yes, filter the results based on the search query
  def index
    @power_banks = PowerBank.all
    authorize @power_banks  # Use `authorize` to check authorization

    # render json: @power_banks

  if params[:search].present?
    @power_banks = @power_banks.where("serial_number LIKE ?", "%#{params[:search]}%")
  end
    render("power_banks/PowerBanks")
  end

# GET /power banks/new
# Prepares a new power bank instance for creation.
  def new
    @power_banks =   PowerBank.new
    authorize @power_banks
  end

# GET /power banks/:id
# Shows details of a specific power bank.
  def show
    authorize @power_bank  # Authorize individual resource
    render json: @power_bank
  end

# POST /power banks
# This method creates a new instance of the power bank model with the parameters provided in the request.
# It authorizes the creation of the power bank using the `authorize` method.
# If the power bank is successfully saved, it redirects to the power banks_path with a notice and renders a JSON response with the power bank object and a status code of :created.
# If the power bank fails to save, it renders a JSON response with the power bank's errors and a status code of :unprocessable_entity.
#
# @param [Hash] power bank_params - The parameters for creating a new power bank.
# @return [void]
  def create
    @power_bank = PowerBank.new(power_bank_params)
    authorize @power_bank

    if @power_bank.save
      # render json: @power_bank, status: :created, power bank: @power_bank
      redirect_to power_banks_path, notice: 'Power bank was successfully created.'
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end


# PATCH/PUT /power banks/:id
# This method updates the current instance of the power bank model with the parameters provided in the request.
# It authorizes the update of the power bank using the `authorize` method.
# If the power bank is successfully updated, it redirects to the power banks_path with a notice and renders a JSON response with the power bank object.
# If the power bank fails to update, it renders a JSON response with the power bank's errors and a status code of :unprocessable_entity.
#
# @param [Hash] power bank_params - The parameters for updating the power bank.
# @return [void]
  def update
    authorize @power_bank
    if @power_bank.update(power_bank_params)
      # render json: @power_bank
            redirect_to power_banks_path, notice: 'Power bank was successfully updated.'
    else
      render json: @power_bank.errors, status: :unprocessable_entity
    end
  end

# GET /power banks/:id/edit
# Prepares a power bank instance for editing.
   def edit
  @power_banks = PowerBank.find(params[:id])  # Assuming you have an ID param
  if @power_banks.present?
    authorize @power_banks
  else
    # Handle the case where @power bank is nil (e.g., redirect, flash message)
  end
end

# DELETE /power banks/:id
# Deletes a specific power bank.
  def destroy
    authorize @power_bank
    @power_bank.destroy
    redirect_to power_banks_path, notice: 'Power bank was successfully destroyed.'
  end

  private

# Sets the @power bank instance variable based on the :id parameter.

  def set_power_bank
    @power_bank = PowerBank.find(params[:id])
  end

# Defines the parameters permitted for power bank creation and update.
  def power_bank_params
    params.require(:power_bank).permit(:serial_number, :status, :station_id, :warehouse_id, :user_id)
  end

# Handles authorization errors and redirects to appropriate power bank.
     def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end