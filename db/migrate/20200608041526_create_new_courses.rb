# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateNewCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :place, null: false, foreign_key: true
      t.references :style, null: false, foreign_key: true
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :note
      t.integer :row_order
      t.boolean :active
      t.string :slug, index: { unique: true }

      t.timestamps
    end
  end
end
