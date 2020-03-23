# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AdminCoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @course = courses(:base_yoga)
  end

  test "should not get index when unauthenticated" do
    get admin_courses_url
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_courses_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_courses_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_course_url
    assert_response :success
  end

  test "should create course and redirect to nonadmin view" do
    sign_in users(:admin)
    assert_difference('Course.count') do
      post admin_courses_url, params: { course: { name: @course.name + ' difference ' } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_course_url(@course)
    assert_response :success
  end

  test "should update course and redirect to nonadmin index" do
    sign_in users(:admin)
    patch admin_course_url(@course), params: { course: { name: @course.name } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    sign_in users(:admin)
    assert_difference('Course.count', -1) do
      delete admin_course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
