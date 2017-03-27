class UserMailer < ApplicationMailer
  default from: 'info@yesqin.com'
  def welcome_email(id)
    @user = User.find_by(id:id)
    return false if @user.blank?
    @url  = 'http://localhost:8088'
    mail(to:@user.email,subject:"this is my test")
  end
end
