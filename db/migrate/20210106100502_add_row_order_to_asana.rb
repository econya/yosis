# SPDX-FileCopyrightText: 2021 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddRowOrderToAsana < ActiveRecord::Migration[6.0]
  def change
    add_column :asanas, :row_order, :integer

    # Newest Asana will rank highest (be first).
    Asana.all.order(created_at: :desc).each do |asana|
      # lesson.update!(row_order: lesson.created_at.to_i)
      # For compatibility with "newer" validations and rank_order definition
      Asana.connection.execute("UPDATE asanas SET row_order = #{asana.created_at.to_i} WHERE id = #{asana.id}")
    end
  end
end
