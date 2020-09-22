# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddInfoToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :info, :string
  end
end
