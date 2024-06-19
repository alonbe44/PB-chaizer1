class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:create]
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!, only: [:create]
  before_action :ensure_admin!, only: [:create]

  # Create a new user with the provided parameters.
  #
  # This method creates a new instance of the User model with the parameters provided in the request.
  # If the user is successfully saved, it redirects to the users_path and renders a JSON response with the user object and a status code of :created.
  # If the user fails to save, it renders a JSON response with the user's errors and a status code of :unprocessable_entity.
  #
  # @param [Hash] user_params - The parameters for creating a new user.
  # @return [void]
  def create
    user = User.new(user_params)
    if user.save
      redirect_to users_path
      #render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

# Private methods for handling user parameters and ensuring admin privileges.

# Extracts the permitted parameters for creating a new user.
#
# This method extracts the permitted parameters from the request parameters and returns them as a hash.
# It requires the :user key and permits the :email, :password, :password_confirmation, and :role keys.
#
# @return [Hash] The permitted parameters for creating a new user.
def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

# Ensures that the current user is an admin.
#
# This method checks if the current user has admin privileges by calling the `admin?` method on the `current_user` object.
# If the current user is not an admin, it renders a JSON response with an error message and a status code of :forbidden.
#
# @return [void]
  def ensure_admin!
    unless current_user&.admin?
      render json: { error: 'Only admin users can create new users' }, status: :forbidden
    end
  end
end
