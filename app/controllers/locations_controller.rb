class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # GET /locations
  # Fetches all locations and renders them in a view.
  def index
    @locations = policy_scope(Location)
    authorize @locations
    #render json: @locations, include: ['stations']
    render("locations/locations")
  end

  # GET /locations/new
  # Prepares a new location instance for creation.
  def new
    @location = Location.new
    authorize @location
  end

  # GET /locations/:id
  # Shows details of a specific location.
  def show
    authorize @location
    render json: @location, include: ['stations']
  end

# POST /locations
# This method creates a new instance of the Location model with the parameters provided in the request.
# It authorizes the creation of the location using the `authorize` method.
# If the location is successfully saved, it redirects to the locations_path with a notice and renders a JSON response with the location object and a status code of :created.
# If the location fails to save, it renders a JSON response with the location's errors and a status code of :unprocessable_entity.
#
# @param [Hash] location_params - The parameters for creating a new location.
# @return [void]
  def create
    @location = Location.new(location_params)
    authorize @location

    if @location.save
      redirect_to locations_path, notice: 'Location was successfully Created.'
      #render json: @location, status: :created, location: @location
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

# PATCH/PUT /locations/:id
# This method updates the current instance of the Location model with the parameters provided in the request.
# It authorizes the update of the location using the `authorize` method.
# If the location is successfully updated, it redirects to the locations_path with a notice and renders a JSON response with the location object.
# If the location fails to update, it renders a JSON response with the location's errors and a status code of :unprocessable_entity.
#
# @param [Hash] location_params - The parameters for updating the location.
# @return [void]
   def update
    authorize @location
    if @location.update(location_params)
      #render json: @location
      redirect_to locations_path, notice: 'Location was successfully Updated.'
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # GET /locations/:id/edit
  # Prepares a location instance for editing.
 def edit
  @location = Location.find(params[:id])  # Assuming you have an ID param
  if @location.present?
    authorize @location
  else
    flash[:alert] = 'Location not found.'
    redirect_to locations_path
  end
end

  # DELETE /locations/:id
  # Deletes a specific location.
  def destroy
    authorize @location
    @location.destroy
        redirect_to locations_path, notice: 'Location was successfully destroyed.'
  end

  private

    # Sets the @location instance variable based on the :id parameter.
  def set_location
    @location = Location.find(params[:id])
  end

  # Defines the parameters permitted for location creation and update.
  def location_params
    params.require(:location).permit(:name, :address)
  end

    # Handles authorization errors and redirects to appropriate location.
   def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end
