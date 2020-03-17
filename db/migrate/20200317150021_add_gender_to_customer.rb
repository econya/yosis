class AddGenderToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :gender, :string
  end
end
