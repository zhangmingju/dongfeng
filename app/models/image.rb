class Image < ApplicationRecord
  belongs_to :target, polymorphic: true
  mount_uploader :name, ImageUploader

  def self.get_images(instance)
    image_urls = instance.images.map do |image|
      image.image.url
    end
  end
end
