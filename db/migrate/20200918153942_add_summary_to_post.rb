class AddSummaryToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :summary, :text
  end
end
