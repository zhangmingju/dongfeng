class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  belongs_to :category, counter_cache: true
  before_save :fill_html_content

  private 

  def fill_html_content
    self.content_html = MyMarkdown.render(self.content)
  end


end
