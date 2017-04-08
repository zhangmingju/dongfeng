class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  belongs_to :category, counter_cache: true
  belongs_to :user
  before_save :fill_html_content

  scope :default_order, -> { order("created_at DESC") }
  scope :publish, -> {where("publish_state = ?",1)}
  scope :read_count_order, -> { order("read_count DESC") }
  
  def get_user
    self.user.try(:nick_name) || self.user.try(:email)
  end
  
  private 

  def fill_html_content
    self.content_html = MyMarkdown.render(self.content)
  end


end
