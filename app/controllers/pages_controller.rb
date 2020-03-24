# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class PagesController < ApplicationController
  def home
    @courses = Course.active
  end

  def privacy
    render 'page', locals: {content: SiteSetting['privacy']}
  end

  def terms
    render 'page', locals: {content: SiteSetting['terms']}
  end

  def impressum
    render 'page', locals: {content: SiteSetting['impressum']}
  end

  def explanation
    render 'page', locals: {content: SiteSetting['explanation']}
  end

  def about_us
    render 'page', locals: {content: SiteSetting['about_us']}
  end
end
