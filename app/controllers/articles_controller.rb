class ArticlesController < ApplicationController
  layout 'application'
  def show
    @article = Article.friendly.find(params[:id])
    ArticleReadWorker.perform_async(@article.slug)
    render 'admin/articles/show'
  end

  def index
    if params[:search].present?
      search = params[:search]
      @articles = Article.where("name like ? or content like ?","%#{search}%","%#{search}%").default_order.page(params[:page])
      @article_count = @articles.count
    else
      @articles = Article.default_order.page(params[:page])
      @article_count = Rails.cache.fetch("articles_count",expires_in: 5.minutes) do 
        Article.count
      end
    end
  end
end