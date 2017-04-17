class CategoriesController < ApplicationController
  layout 'application'
  def index
    @categories = Category.includes(:image)
  end
  def show
    @category = Category.friendly.find(params[:id])
    @articles = @category.articles.includes(:user).publish.default_order.page(params[:page])
  end
end