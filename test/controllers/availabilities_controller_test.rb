require 'test_helper'

class AvailabilitiesControllerTest < ActionController::TestCase
  setup do
    @availability = availabilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:availabilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create availability" do
    assert_difference('Availability.count') do
      post :create, availability: { from: @availability.from, to: @availability.to }
    end

    assert_redirected_to availability_path(assigns(:availability))
  end

  test "should show availability" do
    get :show, id: @availability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @availability
    assert_response :success
  end

  test "should update availability" do
    patch :update, id: @availability, availability: { from: @availability.from, to: @availability.to }
    assert_redirected_to availability_path(assigns(:availability))
  end

  test "should destroy availability" do
    assert_difference('Availability.count', -1) do
      delete :destroy, id: @availability
    end

    assert_redirected_to availabilities_path
  end
end
