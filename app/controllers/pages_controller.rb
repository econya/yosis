# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class PagesController < ApplicationController
  def home
    @styles = Style.active.rank(:row_order)
    @places = Place.active.all
  end

  def privacy
    render 'page', locals: {content: SiteSetting['privacy_statement'], site_setting: 'privacy_statement'}
  end

  def terms
    @html_title = t('navigation.pages.terms')
    render 'page', locals: {content: SiteSetting['terms'], site_setting: 'terms'}
  end

  def impressum
    @html_title = t('navigation.pages.impressum')
    render 'page', locals: {content: SiteSetting['impressum'], site_setting: 'impressum'}
  end

  def explanation
    render 'page', locals: {content: SiteSetting['explanation'], site_setting: 'explanation'}
  end

  def about_us
    @html_title = t('about_us')
    render 'page', locals: {content: SiteSetting['about_us'], site_setting: 'about_us'}
  end
end
