# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class RenameCoursesToStyles < ActiveRecord::Migration[6.0]
  def change
    rename_table :courses, :styles
    rename_column :appointments, :course_id, :style_id
    rename_column :lessons, :course_id, :style_id
  end
end
