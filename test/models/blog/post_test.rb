# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class Blog::PostTest < ActiveSupport::TestCase
  test "#next" do
    post = blog_posts(:second_post)
    assert_equal blog_posts(:third_post), post.next
    assert_nil blog_posts(:third_post).next
  end

  test "#previous" do
    post = blog_posts(:second_post)
    assert_equal blog_posts(:first_post), post.previous
    assert_nil blog_posts(:first_post).previous
  end
end
