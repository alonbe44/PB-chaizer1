class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:create]
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!, only: [:create]
  before_action :ensure_admin!, only: [:create]
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

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def ensure_admin!
    unless current_user&.admin?
      render json: { error: 'Only admin users can create new users' }, status: :forbidden
    end
  end
end
