require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @appointment = appointments(:appointment_one)
  end

  test "should not get index unauthenticated" do
    get admin_appointments_url
    assert_response :redirect
  end

  test "should not get index unauthorized" do
    sign_in users(:user)
    get admin_appointments_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_appointments_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_appointment_url
    assert_response :success
  end

  test "should create appointment and redirect to index" do
    sign_in users(:admin)
    assert_difference('Appointment.count') do
      post admin_appointments_url, params: { appointment: { date_from: @appointment.date_from, date_to: @appointment.date_to, course_id: @appointment.course_id, link: @appointment.link, notice: @appointment.notice } }
    end

    assert_redirected_to admin_appointments_url
  end

  test "should show appointment" do
    sign_in users(:admin)
    get admin_appointment_url(@appointment)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_appointment_url(@appointment)
    assert_response :success
  end

  test "should update appointment" do
    sign_in users(:admin)
    patch admin_appointment_url(@appointment), params: { appointment: { date_from: @appointment.date_from, date_to: @appointment.date_to, course_id: @appointment.course_id, link: @appointment.link, notice: @appointment.notice } }
    assert_redirected_to admin_appointment_url(@appointment)
  end

  test "should destroy appointment" do
    sign_in users(:admin)
    assert_difference('Appointment.count', -1) do
      delete admin_appointment_url(@appointment)
    end

    assert_redirected_to admin_appointments_url
  end
end
