# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class UserAccessHelperTest < ActionView::TestCase
  test "#days_till_end_of_subscription" do
    sue = User.create!(email: 'sue@s.an', password: 'password',
                      password_confirmation: 'password',
                      tos_agreement: true, read_privacy_terms: true,
                      confirmed_at: DateTime.now)
    assert_nil days_till_end_of_subscription(sue)

    sue.subscriptions.create(date_start: DateTime.now - 1.hours, date_end: DateTime.now + 4.days)

    assert_equal 4, days_till_end_of_subscription(sue)

    assert_nil days_till_end_of_subscription(users(:admin))
  end

  test "#days_till_end_of_trial" do
    sue = User.create(email: 'sue@s.an', password: 'password',
                      password_confirmation: 'password', confirmed_at: DateTime.now - 1.days)
    assert_equal 6, days_till_end_of_trial(sue)

    assert_nil days_till_end_of_trial(users(:admin))
  end
end
