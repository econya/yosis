# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
class CreateSeminars < ActiveRecord::Migration[6.0]
  def change
    create_table :seminars do |t|
      t.string :name
      t.text :description
      t.text :description_rendered
      t.integer :row_order
      t.string :slug, index: { unique: true }
      t.boolean :active

      t.timestamps
    end
  end
end
