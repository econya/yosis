class AddDescriptionToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :description, :string
  end
end
