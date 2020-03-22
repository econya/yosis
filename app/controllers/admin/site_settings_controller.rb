# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::SiteSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_site_setting, only: [:show, :edit, :update, :destroy]

  # GET /admin/site_settings
  def index
    SiteSetting.find_or_create_by(key: :intro, value: t('intro_text_homepage'))
    SiteSetting.find_or_create_by(key: :explanation, value: t('explanation_text_homepage'))
    @site_settings = SiteSetting.all
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
        format.html { redirect_to @site_setting, notice: 'Site setting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /site_settings/1
  def update
    respond_to do |format|
      if @site_setting.update(site_setting_params)
        format.html { redirect_to admin_site_settings_path, notice: t('Site setting was successfully updated.') }
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
      params.require(:site_setting).permit(:key, :value)
    end
end