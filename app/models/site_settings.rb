# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SiteSettings
  IMAGE_SETTING_KEYS    = %i[blog_background asana_lexicon_header_image
                             seminars_header_image
                             courses_header_image
                             navbar_right_logo
                             logo favicon favicon-png favicon-apple-touch
                             intro_background]
  MARKDOWN_SETTING_KEYS = %i[intro explanation
                             explanation_trial explanation_login
                             seminars_text
                             privacy_statement terms impressum
                             news_line online_news_line
                             about_us_left about_us_right
                             trial_period_cta register_cta courses_general
                             payment_details]
  STRING_SETTING_KEYS   = %i[your_name title subtitle copyright_notice
                             navbar_right_logo_url]

  def self.find_or_create_settings
    find_or_create_markdown_site_settings
    find_or_create_string_site_settings
    find_or_create_image_site_settings
  end

  def self.find_or_create_image_site_settings
    IMAGE_SETTING_KEYS.each do |key|
      find_or_create(key: key, kind: 'image')
    end
    # i18n-tasks-use t('site_settings.asana_lexicon_header_image.help')
    # i18n-tasks-use t('site_settings.blog_background.help')
    # i18n-tasks-use t('site_settings.favicon-png.help')
    # i18n-tasks-use t('site_settings.favicon-apple-touch.help')
    # i18n-tasks-use t('site_settings.favicon-png.help')
    # i18n-tasks-use t('site_settings.favicon.help')
    # i18n-tasks-use t('site_settings.intro_background.help')
    # i18n-tasks-use t('site_settings.navbar_right_logo.help')
    # i18n-tasks-use t('site_settings.logo.help')
    # i18n-tasks-use t('site_settings.seminars_header_image.help')
    # i18n-tasks-use t('site_settings.courses_header_image.help')
  end

  def self.find_or_create_markdown_site_settings
    MARKDOWN_SETTING_KEYS.each do |key|
      find_or_create(key: key, kind: 'markdown')
    end
    # i18n-tasks-use t('site_settings.about_us.default')
    # i18n-tasks-use t('site_settings.about_us.help')
    # i18n-tasks-use t('site_settings.about_us_left.default')
    # i18n-tasks-use t('site_settings.about_us_left.help')
    # i18n-tasks-use t('site_settings.about_us_right.default')
    # i18n-tasks-use t('site_settings.about_us_right.help')
    # i18n-tasks-use t('site_settings.copyright_notice.default')
    # i18n-tasks-use t('site_settings.copyright_notice.help')
    # i18n-tasks-use t('site_settings.courses_general.default')
    # i18n-tasks-use t('site_settings.courses_general.help')
    # i18n-tasks-use t('site_settings.explanation.default')
    # i18n-tasks-use t('site_settings.explanation.help')
    # i18n-tasks-use t('site_settings.explanation_trial.default')
    # i18n-tasks-use t('site_settings.explanation_trial.help')
    # i18n-tasks-use t('site_settings.explanation_login.help')
    # i18n-tasks-use t('site_settings.explanation_login.default')
    # i18n-tasks-use t('site_settings.impressum.default')
    # i18n-tasks-use t('site_settings.impressum.help')
    # i18n-tasks-use t('site_settings.intro.default')
    # i18n-tasks-use t('site_settings.intro.help')
    # i18n-tasks-use t('site_settings.news_line.default')
    # i18n-tasks-use t('site_settings.news_line.help')
    # i18n-tasks-use t('site_settings.online_news_line.default')
    # i18n-tasks-use t('site_settings.online_news_line.help')
    # i18n-tasks-use t('site_settings.payment_details.default')
    # i18n-tasks-use t('site_settings.payment_details.help')
    # i18n-tasks-use t('site_settings.privacy_statement.default')
    # i18n-tasks-use t('site_settings.privacy_statement.help')
    # i18n-tasks-use t('site_settings.register_cta.default')
    # i18n-tasks-use t('site_settings.register_cta.help')
    # i18n-tasks-use t('site_settings.seminars_text.default')
    # i18n-tasks-use t('site_settings.seminars_text.help')
    # i18n-tasks-use t('site_settings.trial_period_cta.default')
    # i18n-tasks-use t('site_settings.trial_period_cta.help')
    # i18n-tasks-use t('site_settings.terms.default')
    # i18n-tasks-use t('site_settings.terms.help')
  end

  def self.find_or_create_string_site_settings
    STRING_SETTING_KEYS.each do |key|
      find_or_create(key: key, kind: 'string')
    end
    # i18n-tasks-use t('site_settings.title.help')
    # i18n-tasks-use t('site_settings.subtitle.help')
    # i18n-tasks-use t('site_settings.navbar_right_logo_url.help')
    # i18n-tasks-use t('site_settings.your_name.help')
  end

  def self.fetch(key)
    find_or_create(key: key, kind: find_kind(key))
  end

  private

  def self.find_or_create key:, kind:
    SiteSetting.find_or_create_by!(key: key) do |site_setting|
      site_setting.value = I18n.t("site_settings.#{key.to_s}.default")
      site_setting.kind = kind
    end
  end

  def self.find_kind key
    return 'string' if STRING_SETTING_KEYS.include?(key.to_sym)
    return 'markdown' if MARKDOWN_SETTING_KEYS.include?(key.to_sym)
    return 'image' if IMAGE_SETTING_KEYS.include?(key.to_sym)

    raise
  end
end
