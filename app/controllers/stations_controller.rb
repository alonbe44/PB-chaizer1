class StationsController < ApplicationController
  before_action :set_station, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /stations
# Fetches all stations and renders them in a view.
  def index
    @stations = policy_scope(Station)
    authorize @stations
    #Uncomment to enable return Json only
    # render json: @stations
        render("stations/stations")
  end

  # GET /stations/new
# Prepares a new station instance for creation.
  def new
    @stations =   Station.new
    authorize @stations
  end

  # GET /stations/:id
# Shows details of a specific station.
  def show
    authorize @station
    render json: @station
  end


  # POST /stations
# This method creates a new instance of the station model with the parameters provided in the request.
# It authorizes the creation of the station using the `authorize` method.
# If the station is successfully saved, it redirects to the stations_path with a notice and renders a JSON response with the station object and a status code of :created.
# If the station fails to save, it renders a JSON response with the station's errors and a status code of :unprocessable_entity.
#
# @param [Hash] station_params - The parameters for creating a new station.
# @return [void]
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

  # PATCH/PUT /stations/:id
# This method updates the current instance of the station model with the parameters provided in the request.
# It authorizes the update of the station using the `authorize` method.
# If the station is successfully updated, it redirects to the stations_path with a notice and renders a JSON response with the station object.
# If the station fails to update, it renders a JSON response with the station's errors and a status code of :unprocessable_entity.
#
# @param [Hash] station_params - The parameters for updating the station.
# @return [void]

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

  # GET /stations/:id/edit
# Prepares a station instance for editing.
 def edit
  @stations = Station.find(params[:id])  # Assuming you have an ID param
  if @stations.present?
    authorize @stations
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
 end

  # DELETE /stations/:id
# Deletes a specific station.
  def destroy
    authorize @station
    @station.destroy
    redirect_to stations_path, notice: 'Stations was successfully Destroyed.'

  end

  private

  # Sets the @station instance variable based on the :id parameter.

  def set_station
    @station = Station.find(params[:id])
  end

  # Defines the parameters permitted for station creation and update.

  def station_params
    params.require(:station).permit(:name, :status, :location_id, :warehouse_id)
  end

  # Handles authorization errors and redirects to appropriate station.

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end