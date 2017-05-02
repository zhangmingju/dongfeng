class WelcomesController < ApplicationController
  layout 'application'
  def index
    @least_articles = Article.publish.default_order.limit(10)
    @hot_articles = Article.hits_sort.limit(10)
    @categories = Category.includes(:image)
  end
end
