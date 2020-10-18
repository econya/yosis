# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class CreateAsanas < ActiveRecord::Migration[6.0]
  def change
    create_table :asanas do |t|
      t.timestamps
    end
  end
end
