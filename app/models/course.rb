# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class Course < ApplicationRecord
  has_one_attached :image

  has_many :lessons
end
