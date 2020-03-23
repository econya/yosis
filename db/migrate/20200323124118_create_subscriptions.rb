class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date_start
      t.datetime :date_end
      t.text :notes

      t.timestamps
    end
  end
end
