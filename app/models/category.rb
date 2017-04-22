class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one :image, as: :target
  has_many :articles
  validates :name, presence: true, uniqueness: true

  scope :default_order, -> { order("created_at DESC") }

  def image_url
    image_url = self.image.name.url if self.image.present?
    Image.default_image unless File.exist?(image_url)
  end
end
