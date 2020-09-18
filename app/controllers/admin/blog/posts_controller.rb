# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Blog::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @pagy, @posts = pagy(Blog::Post.all)
  end

  def new
    @post = Blog::Post.new
  end

  def create
    @post = Blog::Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: t('admin.blog_post.creation-succes') }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @post = Blog::Post.friendly.find(params[:id])
  end

  def update
    @post = Blog::Post.friendly.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: t('admin.blog_post.update-succes')
    else
      render :edit
    end
  end

  def destroy
    @post = Blog::Post.friendly.find(params[:id])
    @post.destroy
    redirect_to admin_blog_posts_url, notice: t('admin.blog_posts.deletion-success')
  end

  private

    def post_params
      params.require(:blog_post).permit(:title, :content, :summary, :image, :active)
    end
end
