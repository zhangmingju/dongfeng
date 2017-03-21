class UsersController < ApplicationController
  layout 'application'
  def show
  end

  def index
  end

  def update
    ActiveRecord::Base.transaction do
      current_user.update!(update_params)
      if params[:user][:image].present?
        current_user.image.destroy
        ImageUtil.image_upload(params[:user][:image],"User",current_user.id)
      else
        ImageUtil.image_upload(params[:user][:image],"User",current_user.id)
      end
    end
    redirect_to root_path
  end

  private

  def update_params
    params.require(:user).permit(:nick_name, :phone_number)
  end

  # def image_params
  #   params.require(:image).permit(:name)
  # end
end
