# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateAsanaFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :asana_families do |t|
      t.string :name

      t.timestamps
    end
  end
end
