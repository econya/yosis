# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require "application_system_test_case"
require 'test_helper'
require 'action_mailer/test_helper'

class ContactTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
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

    assert_equal ['me@yo.u'], last_email.reply_to
    assert_equal "Kontakt via Webseite", last_email.subject, "Kontakt via Webseite"
    assert_match /Mail from visitor/, last_email.body.to_s
    assert_match /Content \(mail from visitor\)/, last_email.body.to_s
  end

  test "validates contact form on landing page (missing email)" do
    visit root_url

    fill_in "Betreff",   with: 'Mail from visitor'
    fill_in "Nachricht", with: 'Content (mail from visitor)'

    assert_emails 0 do
      click_on "Abschicken"
    end

    last_email  = ActionMailer::Base.deliveries.last
    email_count = ActionMailer::Base.deliveries.size

    assert_selector '#error_explanation', text: 'E-Mail-Adresse ist nicht gültig'
  end

  test "hides email address if user is logged in" do
    user = users(:user)
    sign_in users(:user)

    visit root_url

    refute_selector '#contact_sender_email'

    fill_in "Betreff",   with: 'Mail from visitor'
    fill_in "Nachricht", with: 'Content (mail from visitor)'

    email_count = ActionMailer::Base.deliveries.size

    assert_emails 1 do
      click_on "Abschicken"
    end

    last_email  = ActionMailer::Base.deliveries.last

    assert_equal email_count + 1, ActionMailer::Base.deliveries.size

    assert_equal [user.email], last_email.reply_to
    assert_equal "Kontakt via Webseite", last_email.subject, "Kontakt via Webseite"
    assert_match /Mail from visitor/, last_email.body.to_s
    assert_match /Content \(mail from visitor\)/, last_email.body.to_s
  end
end
