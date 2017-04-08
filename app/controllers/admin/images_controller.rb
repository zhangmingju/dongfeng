class Admin::ImagesController < ApplicationController
  layout 'application'
  before_action :set_image,only:[:edit,:update,:destroy]

  def index
    @images = Image.article_images.default_order.page(params[:page])
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = Image.new(image_params)
    @image.target_type = "Article"
    if @image.save
      redirect_to admin_images_path
    else
      render 'new'
    end
  end

  def update
    if @image.update(image_params)
      redirect_to admin_images_path
    else
      render 'edit' 
    end
  end

  def destroy
    @image.destroy
    redirect_to admin_images_path,notice: '图片成功删除!'
  end

  private 
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:name,:user_id)
    end
end
