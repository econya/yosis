# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "active_today?" do
    subscription = Subscription.new(date_start: DateTime.current - 2.days,
                                    date_end:   DateTime.current + 4.days)

    assert subscription.active_today?

    subscription = Subscription.new(date_start: DateTime.current - 20.days,
                                    date_end:   DateTime.current - 4.days)

    assert_not subscription.active_today?
  end
end
