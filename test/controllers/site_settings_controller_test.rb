# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class SiteSettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @site_setting = site_settings(:title)
  end

  test "should not get index when unauthenticated" do
    get admin_site_settings_url
    assert_response :redirect
  end

  test "should not get index when unauthorized" do
    sign_in users(:user)
    get admin_site_settings_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:admin)
    get admin_site_settings_url
    assert_response :success
  end

#  test "should create site_setting on index visit" do
#    sign_in users(:admin)
#    assert_difference('SiteSetting.count') do
#      post admin_site_settings_url, params: { site_setting: { key: @site_setting.key, value: @site_setting.value } }
#    end
#
#    assert_redirected_to admin_site_setting_url(SiteSetting.last)
#  end

  test "should show site_setting" do
    sign_in users(:admin)
    get admin_site_setting_url(@site_setting)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_admin_site_setting_url(@site_setting)
    assert_response :success
  end

  test "should update site_setting" do
    sign_in users(:admin)
    patch admin_site_setting_url(@site_setting), params: { site_setting: { key: @site_setting.key, value: @site_setting.value } }
    assert_redirected_to admin_site_settings_url
  end

end
