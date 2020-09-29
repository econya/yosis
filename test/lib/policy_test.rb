# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class PolicyTest < ActiveSupport::TestCase
  test "user view post policy" do
    assert Policies::Policy.can_see_blog_post(users(:admin), blog_posts(:intermediate_post))
    refute Policies::Policy.can_see_blog_post(nil, blog_posts(:intermediate_post))
  end
end

