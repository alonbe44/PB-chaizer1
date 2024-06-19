class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /users
# Fetches all users and renders them in a view.
  def index
    @users = User.all
    authorize @users
  end

    # GET /users/:id
# Shows details of a specific user.
  def show
    authorize @user
  end

    # GET /users/new
# Prepares a new user instance for creation.
  def new
    @user = User.new
    authorize @user
  end

    # GET /users/:id/edit
# Prepares a user instance for editing.
  def edit
    authorize @user
  end

  # POST /users
# This method creates a new instance of the user model with the parameters provided in the request.
# It authorizes the creation of the user using the `authorize` method.
# If the user is successfully saved, it redirects to the users_path with a notice and renders a JSON response with the user object and a status code of :created.
# If the user fails to save, it renders a JSON response with the user's errors and a status code of :unprocessable_entity.
#
# @param [Hash] user_params - The parameters for creating a new user.
# @return [void]
  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end


  # PATCH/PUT /users/:id
# This method updates the current instance of the user model with the parameters provided in the request.
# It authorizes the update of the user using the `authorize` method.
# If the user is successfully updated, it redirects to the users_path with a notice and renders a JSON response with the user object.
# If the user fails to update, it renders a JSON response with the user's errors and a status code of :unprocessable_entity.
#
# @param [Hash] user_params - The parameters for updating the user.
# @return [void]

  def update
    authorize @user
    if @user.update(user_params)
      #redirect_to @user, notice: 'User was successfully updated.'
      redirect_to users_path, notice: 'User Details was successfully Updated.'

    else
      render :edit
    end
  end

    # DELETE /users/:id
# Deletes a specific user.
  def destroy
    authorize @user
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Sets the @user instance variable based on the :id parameter.


  def set_user
    Rails.logger.debug "Parameters: #{params.inspect}"
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "User not found."
  end

    # Defines the parameters permitted for user creation and update.

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

    # Handles authorization errors and redirects to appropriate user.
    def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to request.referrer || root_path ,notice: "You are not authorized to perform this action as #{current_user.role} User."

  end
end
