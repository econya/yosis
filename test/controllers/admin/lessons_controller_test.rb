require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @lesson = lessons(:base_yoga_intro)
  end

  test "should not get index when unauthenticated" do
    get admin_course_lessons_url(@lesson.course)
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_course_lessons_url(@lesson.course)
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_course_lessons_url(@lesson.course)
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_admin_course_lesson_url(@lesson.course)
    assert_response :success
  end

  test "should create lesson" do
    sign_in users(:admin)
    assert_difference('Lesson.count') do
      post admin_course_lessons_url(@lesson.course), params: { lesson: { course_id: @lesson.course_id, date_end: @lesson.date_end, date_start: @lesson.date_start } }
    end

    assert_redirected_to lesson_url(Lesson.last)
  end

  test "should show lesson" do
    sign_in users(:admin)
    get admin_course_lesson_url(@lesson.course, @lesson)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_course_lesson_url(@lesson.course, @lesson)
    assert_response :success
  end

  test "should update lesson" do
    sign_in users(:admin)
    patch admin_course_lesson_url(@lesson.course, @lesson), params: { lesson: { course_id: @lesson.course_id, date_end: @lesson.date_end, date_start: @lesson.date_start } }
    assert_redirected_to course_url(@lesson.course)
  end

  test "should destroy lesson" do
    sign_in users(:admin)
    assert_difference('Lesson.count', -1) do
      delete admin_course_lesson_url(@lesson.course, @lesson)
    end

    assert_redirected_to course_url(@lesson.course)
  end
end
