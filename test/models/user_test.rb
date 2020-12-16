# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#admin?" do
    assert users(:admin).admin?
    assert !users(:user).admin?
  end

  test "#subscribed_at?" do
    assert users(:admin).currently_subscribed?
    assert_not users(:user).currently_subscribed?
    assert users(:user).subscribed_at?(DateTime.new(2020,1,10))
  end

  test "#in_trial_period?" do
    assert_not users(:admin).in_trial_period?
    userx = User.create(email: 'userX@yo.sis', password: 'password', password_confirmation: 'password', confirmed_at: DateTime.current - 1.day)
    assert userx.in_trial_period?
    userx.update(confirmed_at: DateTime.current - 8.day)
    assert_not userx.in_trial_period?
  end

  test 'scope #in_trial' do
    # fixture data has none in trial
    assert_equal [], User.in_trial

    userx = users(:user)
    userx.update(confirmed_at: DateTime.current - 1.day)
    assert_equal [userx], User.in_trial.to_a

    userx.update(confirmed_at: DateTime.current - 8.days)

    assert_equal [], User.in_trial.to_a

    userx.subscriptions.create(date_start: DateTime.current - 8.days, date_end: DateTime.current + 8.days)
    assert_equal [], User.in_trial.to_a

    # Now user is subscribed, but in trial wrt confirmation date
    userx.update(confirmed_at: DateTime.current - 2.days)
    assert_equal [], User.in_trial.to_a
  end

  test 'scope #with_current_subscription' do
    # fixture data has none in trial
    assert_equal [], User.with_current_subscription

    userx = users(:user)
    userx.subscriptions.create(date_start: DateTime.current - 8.days, date_end: DateTime.current + 8.days)
    assert_equal [userx], User.with_current_subscription
  end

  test 'scope #trial_started_at' do
    # fixture data has none in trial
    assert_equal [], User.trial_started_at

    userx = users(:user)
    userx.update(confirmed_at: DateTime.current - 7.days)
    assert_equal [userx], User.trial_started_at(day: DateTime.current - 7.days)

    userx.update(confirmed_at: DateTime.current - 6.days)
    assert_equal [], User.trial_started_at(day: DateTime.current - 7.days)
  end

  test 'scope #subscriptions.current' do
    user = users(:user)

    refute user.reload.subscriptions.current.exists?

    user.subscriptions.create(date_start: DateTime.current - 1.days,
                              date_end: DateTime.current + 1.days,
                             notes: 'test note')
    assert user.reload.subscriptions.current.exists?
  end
end
