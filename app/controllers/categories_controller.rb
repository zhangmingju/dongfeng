class CategoriesController < ApplicationController
  layout 'application'
  def index
    @categories = Category.all
  end
  def show
    @category = Category.friendly.find(params[:id])
    @articles = @category.articles.publish.default_order.page(params[:page])
  end
end