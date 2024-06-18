class ApplicationController < ActionController::Base
  include Pundit::Authorization
  #   def after_sign_in_path_for(resource)
  #     "users/index"  # Replace with your actual dashboard path
  # end
end
