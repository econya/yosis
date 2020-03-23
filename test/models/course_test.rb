# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "validates" do
    assert_not Course.new().valid?
    assert_not Course.new(name: '').valid?
    assert_not Course.new(name: '.').valid?
    assert Course.create(name: 'clone')
    assert_not Course.new(name: 'clone').valid?
  end
end
