class AddNickNameAndPhoneNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nick_name, :string
    add_column :users, :phone_number, :string
  end
end
