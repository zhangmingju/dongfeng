class Ability
  include CanCan::Ability

  def initialize(user)
    article_ids = Article.where("user_id = ?", user.id).pluck(:id)
    image_ids = Image.where("user_id = ?", user.id).pluck(:id)
    user ||= User.new
    if user.has_role? :admin
        can :manage, :all
    else
        can [:update,:destroy,:publish], Article, :id=> article_ids
        can [:update,:destroy], Image, :id=> image_ids
    end
  end
end
