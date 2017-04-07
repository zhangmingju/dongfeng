class Image < ApplicationRecord
  belongs_to :target, polymorphic: true
  mount_uploader :name, ImageUploader

  scope :default_order, -> { order("created_at DESC") }
  scope :article_images, -> { where("target_type = ?", "Article") }

  def self.get_images(instance)
    image_urls = instance.images.map do |image|
      image.image.url
    end
  end

  def self.default_image
    "/uploads/image/default.jpg"
  end
end
