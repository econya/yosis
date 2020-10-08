# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Admin::Course::Lesson::PositionController < ApplicationController
  def referenced_model
    Lesson
  end
end
