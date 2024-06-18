class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @locations = policy_scope(Location)
    authorize @locations
    #render json: @locations, include: ['stations']
    render("locations/locations")
  end
  def new
    @location = Location.new
    authorize @location
  end
  def show
    authorize @location
    render json: @location, include: ['stations']
  end

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

  def update
    authorize @location
    if @location.update(location_params)
      #render json: @location
      redirect_to locations_path, notice: 'Location was successfully Updated.'
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end
 def edit
  @location = Location.find(params[:id])  # Assuming you have an ID param
  if @location.present?
    authorize @location
  else
    # Handle the case where @location is nil (e.g., redirect, flash message)
  end
end

  def destroy
    authorize @location
    @location.destroy
        redirect_to locations_path, notice: 'Location was successfully destroyed.'

  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address)
  end

   def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end
