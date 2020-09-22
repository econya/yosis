# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name, index: { unique: true }
      t.string :building_name
      t.string :note
      t.string :address
      t.integer :row_order
      t.boolean :active
      t.string :slug, index: { unique: true }

      t.timestamps
    end
  end
end
