# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Course::PositionController < Admin::PositionController
  def referenced_model
    Course
  end
end
