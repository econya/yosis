# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddContentRenderedToBlogPost < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :content_rendered, :text
    Blog::Post.find_each {|p| p.save!}
  end
end
