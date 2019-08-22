class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one :image, as: :target
  has_many :articles
  validates :name, presence: true, uniqueness: true

  scope :default_order, -> { order("created_at DESC") }

  def image_url
    image_url = self.image.name.url if self.image.present?
    upload_path  = Rails.root.join("public").to_s
    if image_url.present? && File.exist?(upload_path + image_url)
      image_url
    else
      Image.default_image
    end
  end
end
