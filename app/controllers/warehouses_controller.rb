class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


    # GET /warehouses
# Fetches all warehouses and renders them in a view.
  def index
    @warehouses = policy_scope(Warehouse)
    authorize @warehouses
    render("warehouses/Warehouses")
    #render json: @warehouses, include: ['stations', 'power_banks']
  end

      # GET /warehouses/new
# Prepares a new warehouse instance for creation.
    def new
    @warehouses = Warehouse.new
    authorize @warehouses
  end


      # GET /warehouses/:id
# Shows details of a specific warehouse.
  def show
    authorize @warehouse
    render json: @warehouse, include: ['stations', 'power_banks']
  end

    # POST /warehouses
# This method creates a new instance of the warehouse model with the parameters provided in the request.
# It authorizes the creation of the warehouse using the `authorize` method.
# If the warehouse is successfully saved, it redirects to the warehouses_path with a notice and renders a JSON response with the warehouse object and a status code of :created.
# If the warehouse fails to save, it renders a JSON response with the warehouse's errors and a status code of :unprocessable_entity.
#
# @param [Hash] warehouse_params - The parameters for creating a new warehouse.
# @return [void]

  def create
    @warehouse = Warehouse.new(warehouse_params)
    authorize @warehouse

    if @warehouse.save
      #Uncomment to return Json Res
      #render json: @warehouse, status: :created, location: @warehouse
      redirect_to warehouses_path, notice: 'Warehouse was successfully Created.'
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end


    # PATCH/PUT /warehouses/:id
# This method updates the current instance of the warehouse model with the parameters provided in the request.
# It authorizes the update of the warehouse using the `authorize` method.
# If the warehouse is successfully updated, it redirects to the warehouses_path with a notice and renders a JSON response with the warehouse object.
# If the warehouse fails to update, it renders a JSON response with the warehouse's errors and a status code of :unprocessable_entity.
#
# @param [Hash] warehouse_params - The parameters for updating the warehouse.
# @return [void]

  def update
    authorize @warehouse
    if @warehouse.update(warehouse_params)
      #Uncomment to return Json Res
      # render json: @warehouse
      redirect_to warehouses_path, notice: 'Warehouse was successfully Updated.'
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

      # GET /warehouses/:id/edit
# Prepares a warehouse instance for editing.
   def edit
   @warehouses = Warehouse.find(params[:id])  # Assuming you have an ID param
  if @warehouses.present?
    authorize @warehouses
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
end

      # DELETE /warehouses/:id
# Deletes a specific warehouse.
  def destroy
    authorize @warehouse
    @warehouse.destroy
    redirect_to warehouses_path, notice: 'Warehouse was successfully Destroyed.'
  end

  private

      # Sets the @warehouse instance variable based on the :id parameter.

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

      # Defines the parameters permitted for warehouse creation and update.

  def warehouse_params
    params.require(:warehouse).permit(:name, :address)
  end

      # Handles authorization errors and redirects to appropriate warehouse.

  def warehouse_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end