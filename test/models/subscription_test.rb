# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "scope #at" do
    assert Subscription.at(day: DateTime.new(2010,1,1)).empty?
    assert Subscription.at(day: DateTime.new(2020,1,2)).count == 1
  end
end
