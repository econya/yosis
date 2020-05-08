class AddDescriptionToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :description, :text
  end
end
