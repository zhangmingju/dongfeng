class RemoveArticlesCountFromCategory < ActiveRecord::Migration[5.0]
  def change
    # remove_column :categories, :articles_count
    add_column :categories, :articles_count, :integer, :default=>0
  end
end
