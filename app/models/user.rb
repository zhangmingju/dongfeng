class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:github]
  has_one :image, as: :target
  has_many :articles

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
  end

  def image_url
    self.image.present? ? self.image.name.url : Image.default_image
  end

  def self.from_omniauth(auth)
    LoggerApp.info("  auth: #{auth.inspect} ")
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # 因为开启了邮箱验证功能，因此邮箱需要符合条件，同时confirmed_at不能为空，否则无法直接登录。
      user.email = "#{auth.info.email || auth.info.nickname}@github.com" 
      user.password = Devise.friendly_token[0,20]
      user.nick_name = auth.info.name
      user.phone_number = auth.uid
      user.confirmed_at = Time.now
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # Override Devise to send mails with async
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
