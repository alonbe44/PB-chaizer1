class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @warehouses = policy_scope(Warehouse)
    authorize @warehouses
    render json: @warehouses, include: ['stations', 'power_banks']
  end

  def show
    authorize @warehouse
    render json: @warehouse, include: ['stations', 'power_banks']
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    authorize @warehouse

    if @warehouse.save
      render json: @warehouse, status: :created, location: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @warehouse
    if @warehouse.update(warehouse_params)
      render json: @warehouse
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @warehouse
    @warehouse.destroy
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :address)
  end
end