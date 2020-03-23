# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test "scopes" do
    # TODO use time jumping instead
    assert_equal 1, Appointment.past.count
    assert_equal 1, Appointment.future.count

    Appointment.create!(date_from: DateTime.current + 2.days,
                        course: courses(:base_yoga))
    assert_equal 2, Appointment.future.count
  end
end
