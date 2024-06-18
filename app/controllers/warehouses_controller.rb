class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @warehouses = policy_scope(Warehouse)
    authorize @warehouses
    render("warehouses/Warehouses")
    #render json: @warehouses, include: ['stations', 'power_banks']
  end
    def new
    @warehouses = Warehouse.new
    authorize @warehouses
  end

  def show
    authorize @warehouse
    render json: @warehouse, include: ['stations', 'power_banks']
  end

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
   def edit
   @warehouses = Warehouse.find(params[:id])  # Assuming you have an ID param
  if @warehouses.present?
    authorize @warehouses
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
end

  def destroy
    authorize @warehouse
    @warehouse.destroy
    redirect_to warehouses_path, notice: 'Warehouse was successfully Destroyed.'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :address)
  end
end