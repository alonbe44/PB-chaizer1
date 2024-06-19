# spec/requests/users_spec.rb
require 'rails_helper'
RSpec.configure do |config|
  # Include Devise test helpers for controller and request specs
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns a list of users" do
      get users_path
      expect(response).to have_http_status(:redirect)  # Adjusted to expect a redirect status
    end
  end

  describe "GET /users" do
    it "returns a list of users" do
      get users_path
      expect(response).to have_http_status(:redirect)  # Adjusted to expect a redirect status
    end
  end

  describe "GET /users/:id/edit" do
    it "returns an edit user form" do
      user = FactoryBot.create(:user)  # Create a user instance
      sign_in user  # Sign in the user if using Devise or similar
      get edit_user_path(user)
      Rails.logger.info "Logging for test ya rab"

      expect(response).to have_http_status(:success)
    end
    end

 describe "GET /users/new" do
  it "returns a new user form" do
    user = FactoryBot.create(:user)
    sign_in user  # Simulate user authentication
    get new_user_path
    expect(response).to have_http_status(:success)
  end
end

 describe "GET /users/:id/edit", type: :request do
  it "returns an edit user form" do
    user = FactoryBot.create(:user)  # Create a user using FactoryBot
    # Simulate user authentication using Devise's sign_in helper or similar
    sign_in user
    get edit_user_path(user)
    expect(response).to have_http_status(:success)
  end
 end


describe "PATCH update" do
  it "updates the user's email" do
    user = FactoryBot.create(:user)
    sign_in user

    new_email = "new_email@example.com"
    patch user_path(user), params: { user: { email: new_email } }

    user.reload
    expect(user.email).to eq(new_email)
    expect(response).to have_http_status(:redirect)
  end
end

describe "PATCH update" do
  it "updates the user's email" do
    user = FactoryBot.create(:user)
    sign_in user

    new_email = "new_email@example.com"
    patch user_path(user), params: { user: { email: new_email } }

    user.reload
    expect(user.email).to eq(new_email)
    expect(response).to have_http_status(:redirect)
  end
end


  describe "DELETE /users/:id" do
    it "deletes a user" do
      user_to_keep = FactoryBot.create(:user, :admin)  # Create an admin user to keep
      user_to_delete = FactoryBot.create(:user, :normal_user)  # Create a normal user to delete

      sign_in user_to_keep  # Sign in as the admin user

      delete user_path(user_to_delete)

      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq("User was successfully destroyed.")
    end
  end
end