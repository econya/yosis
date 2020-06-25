# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddPricingNoteToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :pricing_note, :string
  end
end
