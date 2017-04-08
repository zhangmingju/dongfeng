class AddReadCountAndPublishStateToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :read_count, :integer, :default => 0
    add_column :articles, :publish_state, :integer, :default => 0
  end
end
