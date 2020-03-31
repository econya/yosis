# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AccessStateTest < ActiveSupport::TestCase
  test "#level none for nil" do
    assert_equal :none, AccessState.new(nil).level
  end

  test "#level none for users without confirmation" do
    assert_equal :none, AccessState.new(users(:unconfirmed_user)).level
  end

  test "#level :admin for admins" do
    assert_equal :admin, AccessState.new(users(:admin)).level
  end

  test "#level :trial for users in trial" do
    users(:user).update(confirmed_at: Date.current - 1.day)
    assert_equal :trial, AccessState.new(users(:user)).level
  end

  test "#level :none for users after trial" do
    users(:user).update(confirmed_at: Date.current - 8.day)
    assert_equal :none, AccessState.new(users(:user)).level
  end

  test "#level :full for users in subscription" do
    users(:user).subscriptions.create(date_start: DateTime.current - 1.day, date_end: DateTime.current + 1.day)
    assert_equal :full, AccessState.new(users(:user)).level
  end

  test "#level :none for users after subscription" do
    users(:user).subscriptions.create(date_start: DateTime.current - 5.day, date_end: DateTime.current - 1.day)
    assert_equal :none, AccessState.new(users(:user)).level
  end
end
