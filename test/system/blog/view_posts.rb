# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class ViewPostsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit blog_posts_url
    assert_selector 'h2', text: blog_posts(:first_post).title.upcase
    assert_selector 'h2', text: blog_posts(:second_post).title.upcase
    assert_selector 'h2', text: blog_posts(:third_post).title.upcase
  end

  test "visit a single post" do
    post = blog_posts(:first_post)
    visit blog_post_path(post)
    assert_selector "h1", text: post.title.upcase
  end
end
