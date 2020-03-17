class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :birthyear
      t.string :avatar
      t.string :contact

      t.timestamps
    end
  end
end
