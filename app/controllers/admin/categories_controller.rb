class Admin::CategoriesController < Admin::AdminController
  layout 'application'
  before_action :set_category,only:[:edit,:update,:destroy]
  load_and_authorize_resource :only => [:new, :edit]

  def index
    @categories = Category.all.default_order
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do 
      @category = Category.new(category_params)
      if @category.save
        ImageUtil.image_upload(params[:category][:image],"Category",@category.id) if params[:category][:image].present?
        redirect_to admin_categories_path
      else
        render 'new'
      end
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render 'edit' 
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path,notice: '分类成功删除!'
  end

  private 
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name,:desc)
    end

end

