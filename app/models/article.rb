class Article < ApplicationRecord
  extend FriendlyId

  include A

  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  
  belongs_to :category, counter_cache: true
  belongs_to :user
  before_save :fill_html_content
  before_destroy :delete_hits_cache_key

  scope :default_order, -> { order("created_at DESC") }
  scope :publish, -> {where("publish_state = ?",1)}

  def get_user
    self.user.try(:nick_name) || self.user.try(:email)
  end

  def self.hits_sort
    article_hash = Hash.new
    Article.publish.each do |article|
      article_hash.merge!({ article.id => article.hits})
    end
    article_arr = article_hash.sort do |a,b|
      b[1] <=> a[1]
    end
    article_ids = article_arr.map { |article| article[0] }
    if article_ids.present?
      Article.where("id in (:ids)",:ids=> article_ids).order("FIELD(id,#{article_ids.join(',')})")
    else
      Article.where(id: [])
    end
  end

  def hits
    cache_key = self.hits_cache_key
    $redis.get(cache_key).to_i
  end

  def incr_hits
    cache_key = self.hits_cache_key
    $redis.incr(cache_key)
  end

  def delete_hits_cache_key
    $redis.del(hits_cache_key)
  end

  def hits_cache_key
    ["hits",self.id,self.created_at.to_i].join("_")
  end

  private

  def fill_html_content
    self.content_html = MyMarkdown.render(self.content)
  end


end
