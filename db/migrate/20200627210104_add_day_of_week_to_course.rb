class AddDayOfWeekToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :dayofweek, :integer
  end
end
