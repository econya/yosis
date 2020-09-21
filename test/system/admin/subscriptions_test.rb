# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class Admin::SubscriptionsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @admin_subscription = subscriptions(:one)
    @user = users(:user)
  end

  #test "should not get new as nobody" do
  #  get new_admin_user_subscription_url(@user)
  #  assert_response :redirect
  #end

  test "visiting the index" do
    sign_in users(:admin)
    visit admin_user_url(@user)
    assert_selector "h2", text: ignorecase("Abonnements")
  end

  test "creating a Subscription" do
    sign_in users(:admin)
    visit admin_user_url(@user)
    click_on "Neues Abo"

    fill_in "Notes", with: "Notes: #{@admin_subscription.notes}"
    click_on "Save"

    assert_text "Abonnement hinzugefügt"
    assert_text "Notes:"
  end

  test "updating a Subscription" do
    sign_in users(:admin)

    visit admin_user_url(@user)
    refute_text "Edited:"

    click_on "Bearbeiten", match: :first

    #fill_in "Date end", with: @admin_subscription.date_end
    #fill_in "Date start", with: @admin_subscription.date_start
    fill_in "Notes", with: "Edited: #{@admin_subscription.notes}"
    click_on "Save"

    assert_text "Abonnement aktualisiert"
    assert_text "Edited:"
  end

  test "destroying a Subscription" do
    sign_in users(:admin)

    visit admin_user_url(@user)
    click_on "Löschen", match: :first

    assert_text "Abonnement gelöscht"
  end
end
