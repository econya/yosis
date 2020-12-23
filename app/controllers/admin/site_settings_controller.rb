# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::SiteSettingsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :authorize_admin!

  before_action :set_site_setting, only: [:show, :edit, :update, :destroy]

  # GET /admin/site_settings
  def index
    find_or_create_settings

    @general_settings    = SiteSetting.where(
      key: ['title', 'your_name', 'copyright_notice', 'payment_details',
            'logo', 'favicon', 'favicon-png', 'favicon-apple-touch',
            'navbar_right_logo', 'navbar_right_logo_url'])
    @start_page_settings = SiteSetting.where(
      key: ['intro', 'intro_background', 'news_line',
            'register_cta', 'trial_period_cta'])
    @pages_settings      = SiteSetting.where(
      key: ['about_us_left', 'about_us_right', 'blog_background', 'courses_general', 'impressum',
            'asana_lexicon_header_image',
            'privacy_statement', 'seminars_text', 'seminars_header_image', 'terms',
            'explanation', 'explanation_login', 'explanation_trial'])
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
        format.html { redirect_to back_url_or(admin_site_settings_path),
                      notice: t('.site-setting-successfully-updated') }
      else
        format.html { render :edit }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_site_setting
      @site_setting = SiteSetting.find(params[:id])
      if !@site_setting.present?
        find_or_create_settings
        @site_setting = SiteSetting.find(params[:id])
      end
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
      SiteSettings.find_or_create_markdown_site_settings
    end

    def find_or_create_string_site_settings
      SiteSettings.find_or_create_string_site_settings
    end

    def find_or_create_image_site_settings
      SiteSettings.find_or_create_image_site_settings
    end
end
