class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one :image, as: :target
  has_many :articles
  validates :name, presence: true, uniqueness: true

  scope :default_order, -> { order("created_at DESC") }

  def image_url
    self.image.present? ? self.image.name.url : Image.default_image
  end
end
