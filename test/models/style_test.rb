# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class StyleTest < ActiveSupport::TestCase
  test "which_has_courses scope" do
    assert_equal [styles(:base_yoga)], Style.which_has_courses.to_a
  end

  test "which_has_videos scope" do
    assert_equal [styles(:base_yoga)], Style.which_has_videos.to_a
  end
end
