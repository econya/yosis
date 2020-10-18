# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateAsanaNames < ActiveRecord::Migration[6.0]
  def change
    create_table :asana_names do |t|
      t.string :name
      t.string :language_code
      t.references :asana, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
