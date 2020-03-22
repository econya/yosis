# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#admin?" do
    assert users(:admin).admin?
    assert !users(:user).admin?
  end
end
