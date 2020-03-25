# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

class AddRowOrderToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :row_order, :integer

    # Newest Course will rank highest (be first).
    Course.all.order(created_at: :desc).each do |course|
      course.update!(row_order: course.created_at.to_i)
    end
  end
end
