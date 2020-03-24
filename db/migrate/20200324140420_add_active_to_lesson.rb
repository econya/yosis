class AddActiveToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :active, :boolean
  end
end
