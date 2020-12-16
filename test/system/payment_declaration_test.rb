# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class PaymentDeclarationTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "user should not see 'pay now' button if not logged in" do
    visit explanation_url
    refute_selector "a[href='#{user_payment_declaration_path}']"
  end

  test "user should see 'pay now' button if in trial" do
    user = users(:user)
    sign_in users(:user)

    visit explanation_url

  end
end
