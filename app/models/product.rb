class Product < ApplicationRecord
  has_many :vote_ships

  def vote_user_name
    user_ids = self.vote_ships.pluck(:user_id).uniq
    User.where("id in (:ids)",:ids=>user_ids).pluck(:nick_name)
  end
end
