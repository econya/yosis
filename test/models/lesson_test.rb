# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  test "validates" do
    assert_not Lesson.new().valid?
    assert_not Lesson.new(name: '').valid?
    assert_not Lesson.new(name: '.').valid?
    assert Lesson.create(name: 'clone')
    assert_not Lesson.new(name: 'clone').valid?
    assert true
  end

  test "active_scope" do
    assert_equal 1, Lesson.active.count
  end
end
