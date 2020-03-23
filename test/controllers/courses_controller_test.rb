# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:base_yoga)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end
end
