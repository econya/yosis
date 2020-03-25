class AddInfoToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :info, :string
  end
end
