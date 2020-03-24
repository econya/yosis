class AddActiveToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :active, :boolean
  end
end
