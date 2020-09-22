# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"
require 'test_helper'

class TosTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    Rack::Attack.enabled = false
  end

  test "to sign up, user has to agree to TOS and have readprivacy statement" do
    Rack::Attack.enabled = false

    visit new_user_registration_url

    fill_in "E-Mail",   with: 'my@ma.il'
    fill_in "Passwort", with: 'my@ma.il'
    fill_in "Passwortbestätigung", with: 'my@ma.il'

    click_on "Für Schnupperwoche registrieren"

    assert_selector '#error_explanation'

    check('Datenschutzhinweise gelesen')

    fill_in "Passwort", with: 'my@ma.il'
    fill_in "Passwortbestätigung", with: 'my@ma.il'

    click_on "Für Schnupperwoche registrieren"

    assert_selector '#error_explanation'

    check('Stimme AGB zu')

    fill_in "Passwort", with: 'my@ma.il'
    fill_in "Passwortbestätigung", with: 'my@ma.il'

    click_on "Für Schnupperwoche registrieren"

    assert_selector '.notification', text: /Sie erhalten in wenigen Minuten/
  end

  test "when signed up, dates of consent are saved in User model" do
    skip "tbi"
  end

  test "when logging in and no consent was given, user is forced to agree or delete account" do
    skip "tbi"
  end

  test "admins can update date of tos changes and user has to re-agree or delete account" do
    skip "tbi"
  end
end

