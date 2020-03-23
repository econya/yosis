require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "active_today?" do
    subscription = Subscription.new(date_start: DateTime.now - 2.days,
                                    date_end: DateTime.now + 4.days)

    assert subscription.active_today?

    subscription = Subscription.new(date_start: DateTime.now - 20.days,
                                    date_end: DateTime.now - 4.days)

    assert_not subscription.active_today?
  end
end
