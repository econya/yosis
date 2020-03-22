# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :date_from
      t.datetime :date_to
      t.references :course, null: false, foreign_key: true
      t.string :notice
      t.string :link

      t.timestamps
    end
  end
end
