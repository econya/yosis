# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class DataCopyAboutUsLeftAndRight < ActiveRecord::Migration[6.0]
  def up
    old_about_us = SiteSetting.find_by(key: 'about_us')

    if old_about_us.present?
      new_setting = SiteSetting.find_or_create_by(key: 'about_us_left')

      new_setting.update(kind: 'markdown',
                         value: old_about_us.value,
                         value_rendered: old_about_us.value_rendered)
    end
  end

  def down
    new_about_us = SiteSetting.find_by(key: 'about_us_left')

    if new_about_us.present?
      old_setting = SiteSetting.find_or_create_by(key: 'about_us_left')
      old_setting.update(
        kind: 'markdown',
        value: new_about_us.value,
        value_rendered: new_about_us.value_rendered)
    end
  end
end
