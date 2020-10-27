# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Blog::PostsController < ApplicationController
  def index
    @pagy, @posts = pagy(Blog::Post.published.
                         with_attached_image.order(published_at: :desc))
  end

  def show
    @post = Blog::Post.friendly.find(params[:id])
    if !Policies::Policy.can_see_blog_post current_user, @post
      redirect_to blog_posts_path
    end
  end
end
