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
end
