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
end
