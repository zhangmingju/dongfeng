class ArticlesController < ApplicationController
  layout 'application'
  def show
    @article = Article.friendly.find(params[:id])
    ArticleReadWorker.perform_async(@article.slug)
    render 'admin/articles/show'
  end

  def index
    @articles = Article.default_order.page(params[:page])
  end
end