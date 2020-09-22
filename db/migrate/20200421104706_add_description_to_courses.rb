# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddDescriptionToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :description, :string
  end
end
