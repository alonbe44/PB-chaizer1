# require "test_helper"
#
# class LocationsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @location = locations(:one)  # Load a location fixture
#     @admin_user = users(:admin)  # Load an admin user fixture
#     sign_in @admin_user  # Sign in as the admin user
#   end
#
#   test "should get index" do
#     get locations_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_location_url
#     assert_response :success
#   end
#
#   test "should create location" do
#     assert_difference('Location.count') do
#       post locations_url, params: { location: { name: "New Location", address: "123 Main St" } }
#     end
#
#     assert_redirected_to locations_url
#     assert_equal 'Location was successfully Created.', flash[:notice]
#   end
#
#   test "should show location" do
#     get location_url(@location)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_location_url(@location)
#     assert_response :success
#   end
#
#   test "should update location" do
#     patch location_url(@location), params: { location: { name: @location.name, address: "Updated Address" } }
#     assert_redirected_to locations_url
#     assert_equal 'Location was successfully Updated.', flash[:notice]
#   end
#
#   test "should destroy location" do
#     assert_difference('Location.count', -1) do
#       delete location_url(@location)
#     end
#
#     assert_redirected_to locations_url
#     assert_equal 'Location was successfully destroyed.', flash[:notice]
#   end
# end
