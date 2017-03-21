class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.references :target, polymorphic: true, index:true

      t.timestamps
    end
  end
end
