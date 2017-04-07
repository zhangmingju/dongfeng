class UserImageWorker
  include Sidekiq::Worker

  def perform(user_id)
    begin
      user = User.find(user_id)
      user.default_image
    rescue Exception => e
      LoggerApp.info("  #{self.class.name}.#{__method__}  e.message: #{e.message}")
    end
  end
  
end
