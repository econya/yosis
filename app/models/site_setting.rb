# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class SiteSetting < ApplicationRecord
  validates :key, uniqueness: true

  def self.[](setting_name)
    find_by_key(setting_name)&.value
  end
end
