# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class PaymentDeclarationTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include ActionMailer::TestHelper

  test "user should not see 'pay now' button if not logged in" do
    visit explanation_url
    refute_selector "a[href='#{user_payment_declaration_path}']"
  end

  test "user should see 'pay now' button if in trial" do
    user = users(:user)
    sign_in users(:user)

    visit explanation_url

    assert user.mark_paid_at.nil?
    refute user.currently_subscribed?

    assert_emails 1 do
      click_on "Ich habe bezahlt"
    end

    assert_selector '.notification', text: 'Danke'

    refute user.reload.mark_paid_at.nil?
    assert user.currently_subscribed?

    visit explanation_url
    refute_selector "a[href='#{user_payment_declaration_path}']"

  end
end
