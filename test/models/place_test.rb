# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "#which_has_active_courses scop" do
    assert_equal 1, Place.which_has_active_courses.count
  end
end
