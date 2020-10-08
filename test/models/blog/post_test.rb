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

  test "#previous only looks at active and published posts" do
    post = blog_posts(:second_post)
    previous_post = blog_posts(:first_post)

    assert_equal previous_post, post.previous

    previous_post.update!(active: false)
    assert_nil post.previous

    previous_post.update!(active: true, published_at: nil)
    assert_nil post.previous
  end

  test "#published scope" do
    assert_difference('Blog::Post.published.count', 1) do
      blog_posts(:intermediate_post).update!(published_at: DateTime.current,
                                             active: true)
    end
  end
end
