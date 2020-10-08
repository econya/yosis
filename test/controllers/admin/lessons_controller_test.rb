# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @lesson = lessons(:base_yoga_intro)
  end

  test "should not get index when unauthenticated" do
    get admin_style_lessons_url(@lesson.style)
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_style_lessons_url(@lesson.style)
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_style_lessons_url(@lesson.style)
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_style_lesson_url(@lesson.style)
    assert_response :success
  end

  test "should create lesson" do
    sign_in users(:admin)
    assert_difference('Lesson.count') do
      post admin_style_lessons_url(@lesson.style), params: { lesson:
        { style_id: @lesson.style_id,
          date_end: @lesson.date_end,
          date_start: @lesson.date_start,
          preview_image: fixture_file_upload('files/white_pixel.png'),
          video: fixture_file_upload('files/white_pixel.png'),
          name: 'Test-a-less' } }
    end

    assert_redirected_to style_url(Lesson.last.style)
  end

  test "should show lesson" do
    sign_in users(:admin)
    get admin_style_lesson_url(@lesson.style, @lesson)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_style_lesson_url(@lesson.style, @lesson)
    assert_response :success
  end

  test "should update lesson" do
    sign_in users(:admin)

    patch admin_style_lesson_url(@lesson.style, @lesson), params: {
      lesson: { style_id: @lesson.style_id,
                date_end: @lesson.date_end,
                date_start: @lesson.date_start,
                video: fixture_file_upload('files/white_pixel.png')
                #preview_image: 'def' } }
                }}

    assert_redirected_to style_url(@lesson.style)
  end

  test "should destroy lesson" do
    sign_in users(:admin)
    assert_difference('Lesson.count', -1) do
      delete admin_style_lesson_url(@lesson.style, @lesson)
    end

    assert_redirected_to style_url(@lesson.style)
  end
end
