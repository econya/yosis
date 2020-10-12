# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"

class Admin::CmsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "can click on an admin button" do
    sign_in users(:admin)

    SiteSetting.find_or_create_by(key: 'privacy_statement')
      .update!(value: 'the statement')

    visit privacy_path
    
    assert page.find('#privacy_statement')

    page.find('.admin-edit-area').hover
    page.find('.admin-button').click

    fill_in 'Wert', with: 'We value'
    click_on "Speichern"

    assert_equal privacy_path, page.current_path

    assert_text 'We value'
  end
end
