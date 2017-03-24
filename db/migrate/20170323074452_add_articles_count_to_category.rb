class AddArticlesCountToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :articles_count, :integer
  end
end
