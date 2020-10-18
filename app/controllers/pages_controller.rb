# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class PagesController < ApplicationController
  def home
    @styles = Style.active.rank(:row_order)
    @places = Place.active.rank(:row_order)
  end

  def asana_lexicon
    @html_title = t('navigation.asana-lexicon')
    @asanas = Asana.all
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

  def courses_general
    @html_title = t('pages.courses_general')
    render 'page', locals: {content: SiteSetting['courses_general'], site_setting: 'courses_general'}
  end
end
