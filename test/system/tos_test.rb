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
    visit new_user_registration_url

    fill_in "E-Mail",   with: 'my@ma.il'
    fill_in "Passwort", with: 'my@ma.il'
    fill_in "Passwortbestätigung", with: 'my@ma.il'

    check('Datenschutzhinweise gelesen')
    check('Stimme AGB zu')

    click_on "Für Schnupperwoche registrieren"

    assert_in_delta DateTime.now.to_i, User.last.terms_accepted_at.to_i, 5
  end

  test "when logging in and no consent was given, user is forced to agree or delete account" do
    visit new_user_session_path

    user = users(:user_without_tos_acceptance)

    fill_in "E-Mail", with: user.email
    fill_in "Passwort", with: 'userpwd'

    click_on "Anmelden"

    assert_selector '.notification', text: /Du musst/
    assert_selector 'button', text: 'gelesen'
    assert_selector 'button', text: 'löschen'
  end

  test "admins can update date of tos changes and user has to re-agree or delete account" do
    skip "tbi"
  end

  test "admins do not need to accept the terms" do
    skip "tbi"
  end
end

