class CreateAsanaAsanaFamily < ActiveRecord::Migration[6.0]
  def change
    create_table :asana_asana_families do |t|
      t.references :asana, null: false, foreign_key: true
      t.references :asana_family, null: false, foreign_key: true
    end
  end
end
