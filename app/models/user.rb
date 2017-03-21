class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :image, as: :target

  validates :phone_number, uniqueness: true
  validates :nick_name, presence: true

  def default_image
    defalt_flag = self.nick_name || self.email
      file_path = LetterAvatar.generate(defalt_flag,200)
      image = Image.new(target_type:"User",target_id:self.id)
      File.open(file_path,"r") do |f|
        image.name = f
      end
      image.save!
    true
  end
end
