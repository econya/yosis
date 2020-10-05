# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddRowOrderToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :row_order, :integer

    # Newest Lesson will rank highest (be first).
    Lesson.all.order(created_at: :desc).each do |lesson|
      # lesson.update!(row_order: lesson.created_at.to_i)
      # For compatibility with "newer" validations and rank_order definition
      Lesson.connection.execute("UPDATE lessons SET row_order = #{lesson.created_at.to_i} WHERE id = #{lesson.id}")
    end
  end
end
