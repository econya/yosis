class ChangeSiteSetting < ActiveRecord::Migration[6.0]
  def change
    change_column :site_settings, :value, :text
    add_column :site_settings, :value_rendered, :text
    add_column :site_settings, :kind, :string
  end
end
