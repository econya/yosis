class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
