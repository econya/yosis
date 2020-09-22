# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"
require 'test_helper'
require 'action_mailer/test_helper'

class ContactTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  setup do
    @course = courses(:studio_north_tuesday)
  end

  test "Send mail via contact form on landing page" do
    visit root_url

    fill_in "Betreff",   with: 'Mail from visitor'
    fill_in "Nachricht", with: 'Content (mail from visitor)'
    fill_in "E-Mail-Adresse", with: 'me@yo.u'

    assert_emails 1 do
      click_on "Abschicken"
    end

    last_email  = ActionMailer::Base.deliveries.last
    email_count = ActionMailer::Base.deliveries.size

    assert_equal 1, email_count
  end

  # TODO test different case (logged in user, user gives phone, invalid form,
  # ...)
  test "validates contact form on landing page" do
    visit root_url

    fill_in "Betreff",   with: 'Mail from visitor'
    fill_in "Nachricht", with: 'Content (mail from visitor)'

    assert_emails 0 do
      click_on "Abschicken"
    end

    last_email  = ActionMailer::Base.deliveries.last
    email_count = ActionMailer::Base.deliveries.size

    assert_equal 0, email_count
  end
end
