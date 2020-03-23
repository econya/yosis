# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Appointment < ApplicationRecord
  belongs_to :course

  scope :future, -> { where("date_from >= ?", DateTime.current) }
  scope :past,   -> { where("date_from < ?",  DateTime.current) }
end
