# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class Admin::CoursesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @course = courses(:studio_north_tuesday)
  end

  test "creating a Course" do
    sign_in users(:admin)

    visit admin_courses_url
    first('.level-right').click_link("Neu")

    fill_in "Name", with: @course.name
    select "Mittwoch", :from => "course_dayofweek"
    select "Basic Yoga", :from => "course_style_id"
    select "Place Two", :from => "course_place_id"

    click_on "Save"

    assert_text "Kurs erstellt"
  end

  test "updating a Course" do
    sign_in users(:admin)

    visit admin_courses_url
    click_on "bearbeiten", match: :first

    fill_in "Name", with: @course.name + "_edit"
    click_on "Save"

    assert_text "Kurs aktualisiert"

    assert_text "#{@course.name}_edit"
  end

  test "destroying a Course" do
    sign_in users(:admin)

    visit admin_courses_url
    page.accept_confirm do
      click_on "Löschen", match: :first
    end

    assert_text "Kurs gelöscht"
  end
end
