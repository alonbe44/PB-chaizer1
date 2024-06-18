class StationsController < ApplicationController
  before_action :set_station, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @stations = policy_scope(Station)
    authorize @stations
    #Uncomment to enable return Json only
    # render json: @stations
        render("stations/stations")
  end
  def new
    @stations =   Station.new
    authorize @stations
  end
  def show
    authorize @station
    render json: @station
  end

  def create
    @station = Station.new(station_params)
    authorize @station

    if @station.save
      #Uncomment to enable return Json only
      #render json: @station, status: :created, location: @station
      redirect_to stations_path, notice: 'Stations was successfully Created.'

    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @station
    if @station.update(station_params)
      #Uncomment to enable return Json only
      #render json: @station
      redirect_to stations_path, notice: 'Stations was successfully Updated.'
    else
      render json: @station.errors, status: :unprocessable_entity
    end
  end
 def edit
  @stations = Station.find(params[:id])  # Assuming you have an ID param
  if @stations.present?
    authorize @stations
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
end
  def destroy
    authorize @station
    @station.destroy
    redirect_to stations_path, notice: 'Stations was successfully Destroyed.'

  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end
end