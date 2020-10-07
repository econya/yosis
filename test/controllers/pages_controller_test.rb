# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "shows page" do
    get root_path
    assert_response :success
  end

  test "shows rendered term page" do
    terms_setting = SiteSetting.find_or_create_by(key: 'terms')
    terms_setting.update!(value: '# term-heading', kind: 'markdown')

    get terms_path

    assert_select 'h1', 'term-heading'

    assert_response :success
  end

  test "shows rendered privacy statement page" do
    privacy_setting = SiteSetting.find_or_create_by(key: 'privacy_statement')
    privacy_setting.update!(value: '## privacy', kind: 'markdown')

    get privacy_path

    assert_select 'h2', 'privacy'

    assert_response :success
  end
end
