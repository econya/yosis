# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "validates" do
    assert_not Contact.new().valid?
    assert_not Contact.new(subject: '').valid?
    assert_not Contact.new(subject: '').valid?
    assert_not Contact.new(sender_email: '', subject: '', message: '').valid?
    assert_not Contact.new(sender_email: 'ma@i.', subject: 'test', message: 'test').valid?
    assert_not Contact.new(sender_email: 'ma@i.l', subject: 'test', message: '2short').valid?
    assert Contact.new(sender_email: 'ma@i.l', subject: 'test', message: 'long enough for this').valid?
    assert Contact.new(phone_number: 'ma@i.', subject: 'test', message: 'long enough for this').valid?
  end
end
