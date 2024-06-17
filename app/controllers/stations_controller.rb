class StationsController < ApplicationController
  before_action :set_station, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @stations = policy_scope(Station)
    authorize @stations
    render json: @stations
  end

  def show
    authorize @station
    render json: @station
  end

  def create
    @station = Station.new(station_params)
    authorize @station

    if @station.save
      render json: @station, status: :created, location: @station
    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @station
    if @station.update(station_params)
      render json: @station
    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @station
    @station.destroy
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end
end