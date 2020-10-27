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
    @asanas = Asana.includes(:german_asana_names,
                             :english_asana_names,
                             :sanskrit_asana_names,
                             :asana_families,
                             :image_attachment).all
  end

  def privacy
    render 'page', locals: { site_setting: 'privacy_statement' }
  end

  def terms
    @html_title = t('navigation.pages.terms')
    render 'page', locals: { site_setting: 'terms' }
  end

  def seminars
    @html_title = t('navigation.seminars')
    render 'page', locals: { site_setting: 'seminars_text',
                             header_image_setting: 'seminars_header_image' }
  end

  def impressum
    @html_title = t('navigation.pages.impressum')
    render 'page', locals: { site_setting: 'impressum' }
  end

  def explanation
    render 'page', locals: { site_setting: 'explanation' }
  end

  def courses_general
    @html_title = t('pages.courses_general')
    render 'page', locals: { site_setting: 'courses_general' }
  end
end
