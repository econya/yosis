# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class SiteSettingTest < ActiveSupport::TestCase
  test "uniqueness" do
    SiteSetting.create!(key: 'contact_mail', value: 'bogus')
    assert_raises { SiteSetting.create!(key: 'contact_mail', value: 'bogus') }
  end

  test "hash-like access" do
    assert_equal 'The YoSis Studio', SiteSetting['title']
  end

  test "renders markdown and stores it" do
    setting = SiteSetting.create!(key: 'some_content', value: '**bold**', kind: 'markdown')
    assert_equal "<p><strong>bold</strong></p>\n", setting.value_rendered
  end

  test "accesses markdown also with brackets" do
    setting = SiteSetting.create!(key: 'some_content', value: '**bold**', kind: 'markdown')
    assert_equal "<p><strong>bold</strong></p>\n", SiteSetting['some_content']
  end
end
