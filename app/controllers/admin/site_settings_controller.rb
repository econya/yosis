# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::SiteSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_site_setting, only: [:show, :edit, :update, :destroy]

  # GET /admin/site_settings
  def index
    find_or_create_settings

    @general_settings    = SiteSetting.where(
      key: ['title', 'your_name', 'copyright_notice', 'payment_details',
            'logo', 'favicon', 'favicon-png', 'favicon-apple-touch'])
    @start_page_settings = SiteSetting.where(
      key: ['intro', 'intro_background', 'news_line',
            'register_cta', 'trial_period_cta'])
    @pages_settings      = SiteSetting.where(
      key: ['about_us', 'courses_general', 'impressum', 'privacy_statement',
            'terms', 'explanation'])
  end

  def show
  end

  # GET /admin/site_settings/new
  def new
    @site_setting = SiteSetting.new
  end

  # GET /admin/site_settings/1/edit
  def edit
  end

  # POST /site_settings
  def create
    @site_setting = SiteSetting.new(site_setting_params)

    respond_to do |format|
      if @site_setting.save
        format.html { redirect_to @site_setting, notice: t('.sitesetting-successfully-created') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /site_settings/1
  def update
    respond_to do |format|
      if @site_setting.update(site_setting_params)
        # Nicer redirection, please!
        format.html { redirect_to admin_site_settings_path, notice: t('.site-setting-successfully-updated') }
      else
        format.html { render :edit }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_setting
      @site_setting = SiteSetting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def site_setting_params
      params.require(:site_setting).permit(:key, :value, :image)
    end

    def find_or_create_settings
      find_or_create_markdown_site_settings
      find_or_create_string_site_settings
      find_or_create_image_site_settings
    end

    def find_or_create_markdown_site_settings
      md_keys = [:intro, :explanation, :privacy_statement, :terms, :impressum,
                 :copyright_notice, :about_us, :trial_period_cta,
                 :register_cta, :courses_general, :payment_details]
      md_keys.each do |key|
        SiteSetting.find_or_create_by(key: key,
          kind: "markdown",
          value: t("site_settings.#{key.to_s}.default"))
      end
      # i18n-tasks-use t('site_settings.about_us.default')
      # i18n-tasks-use t('site_settings.about_us.help')
      # i18n-tasks-use t('site_settings.copyright_notice.default')
      # i18n-tasks-use t('site_settings.copyright_notice.help')
      # i18n-tasks-use t('site_settings.courses_general.default')
      # i18n-tasks-use t('site_settings.courses_general.help')
      # i18n-tasks-use t('site_settings.explanation.default')
      # i18n-tasks-use t('site_settings.explanation.help')
      # i18n-tasks-use t('site_settings.impressum.default')
      # i18n-tasks-use t('site_settings.impressum.help')
      # i18n-tasks-use t('site_settings.intro.default')
      # i18n-tasks-use t('site_settings.intro.help')
      # i18n-tasks-use t('site_settings.payment_details.default')
      # i18n-tasks-use t('site_settings.payment_details.help')
      # i18n-tasks-use t('site_settings.privacy_statement.default')
      # i18n-tasks-use t('site_settings.privacy_statement.help')
      # i18n-tasks-use t('site_settings.register_cta.default')
      # i18n-tasks-use t('site_settings.register_cta.help')
      # i18n-tasks-use t('site_settings.trial_period_cta.default')
      # i18n-tasks-use t('site_settings.trial_period_cta.help')
      # i18n-tasks-use t('site_settings.terms.default')
      # i18n-tasks-use t('site_settings.terms.help')
    end

    def find_or_create_string_site_settings
      string_keys = [:your_name, :title, :news_line]
      string_keys.each do |key|
        SiteSetting.find_or_create_by(key: key,
          value: t("site_settings.#{key.to_s}.default"),
          kind: 'string')
      end
      # i18n-tasks-use t('site_settings.news_line.help')
      # i18n-tasks-use t('site_settings.title.help')
      # i18n-tasks-use t('site_settings.your_name.help')
    end

    def find_or_create_image_site_settings
      image_keys = [:logo, :favicon, "favicon-png", "favicon-apple-touch",
        :intro_background]
      image_keys.each do |key|
        SiteSetting.find_or_create_by(key: key,
          value: t("site_settings.#{key.to_s}.default"),
          kind: 'image')
      end
      # i18n-tasks-use t('site_settings.favicon-apple-touch.help')
      # i18n-tasks-use t('site_settings.favicon-png.help')
      # i18n-tasks-use t('site_settings.favicon.help')
      # i18n-tasks-use t('site_settings.intro_background.help')
      # i18n-tasks-use t('site_settings.logo.help')
    end

end
