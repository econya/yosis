# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:studio_north_tuesday)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector 'h1', text: Regexp.new(I18n.t('courses.listing-heading'), Regexp::IGNORECASE)
    assert_selector ".card-content", text: @course.name
  end

  test "visit a single course" do
    visit course_url(@course)
    assert_selector "h1", text: Regexp.new(@course.name, Regexp::IGNORECASE)
  end
end
