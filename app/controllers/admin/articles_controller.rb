class Admin::ArticlesController < Admin::AdminController
  layout 'application'
  before_action :set_article,only:[:show,:edit,:update,:destroy]

  def index
    @articles = Article.includes(:user,:category).default_order.page(params[:page])
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_path
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_path
    else
      render 'edit' 
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path,notice: '文章成功删除!'
  end

  def preview
    content = params[:content]
    html_content = MyMarkdown.render(content)
    render json:{html_content: html_content}
  end

  private 
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:name,:content,:user_id,:category_id)
    end
end
