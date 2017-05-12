class CreateVoteShips < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_ships do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :vote_ships, :user_id
    add_index :vote_ships, :product_id
  end
end
